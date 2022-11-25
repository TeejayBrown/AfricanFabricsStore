class CheckoutController < ApplicationController
  before_action :authenticate_customer!

  def pay
    product = Product.find(params[:id])
    productOrder = ProductOrder.find_by(product_id: product.id)
    load_taxes(product)
    shippingRate
    # province = Province.find("#{current_customer.address.province_id}")
    # @subtotal = product.price * 1
    # @gst = @subtotal * province.gst_rate
    # @pst = @subtotal * province.pst_rate
    # @hst = @subtotal * province.hst_rate
    # taxes = (@gst + @pst + @hst)/100
    # total = @subtotal + taxes
    # customerId = current_customer.id
    # quantity = 1
    # loadPastOrder(product, productOrder, taxes, total, customerId)
    #loadPastOrder(product, productOrder, taxes, total, customerId)
    #loadPastOrder(product, quantity, taxes, total, customerId)
    #CustomerOrder.where(customer_id: customerId).first_or_create.update(product_name: product.name)
    # CustomerOrder.create(status: "Pending",
    #   product_name: product.name,
    #   product_description: product.description,
    #   product_price: product.price,
    #   product_quantity: 1,
    #   subtotal: product.price * 1,
    #   taxes: taxes,
    #   total: total,
    #   customer_id: customerId,
    #   order_date: Time.now.strftime("%d/%m/%Y %H:%M"))

    @session = Stripe::Checkout::Session.create({
      customer: current_customer.stripe_customer_id,
      payment_method_types: ['card'],
      shipping_address_collection: {allowed_countries: ['US', 'CA']},
      shipping_options: [{shipping_rate: @shipping_rate}],
      success_url: order_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: root_url,
      line_items: [
        price_data: {
          currency: 'cad',
          unit_amount: (product.price * 100).to_i,
          product_data: {
            name: product.name,
            description: product.description,
          },
        },
        quantity: 1,
        tax_rates: @all_taxes,
      ],
      mode: 'payment'
    })

    redirect_to @session.url, allow_other_host: true
  end

  def create
    lineItems = []
    shippingRate
    @order.product_orders.each do |productOrder|
      product = productOrder.product
      load_taxes(product)

      lineItems.push({
        price_data: {
          currency: 'cad',
          unit_amount: (product.price * 100).to_i,
          product_data: {
            name: product.name,
            description: product.description
          },
        },
        quantity: productOrder.quantity,
        tax_rates: @all_taxes,
      })
    end

    @session = Stripe::Checkout::Session.create({
      customer: current_customer.stripe_customer_id,
      payment_method_types: ['card'],
      shipping_address_collection: {allowed_countries: ['US', 'CA']},
      shipping_options: [{shipping_rate: @shipping_rate}],
      success_url: order_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: root_url,
      line_items: lineItems,
      mode: 'payment'
    })

    redirect_to @session.url, allow_other_host: true
  end

  def show

  end

  def success
    session[:order_id] = []
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @customer = Stripe::Customer.retrieve(@session.customer)
    @line_items = Stripe::Checkout::Session.list_line_items(@session.id)
    flash.now[:notice] = "You have succesfully placed an order. Thank you for your order #{@payment_intent.shipping.name}."
  end

  def loadPastOrder(product, productOrder, taxes, total, customerId)
    custOrder = CustomerOrder.new
    custOrder.status = "Pending",
    custOrder.product_name = product.name,
    custOrder.product_description = product.description,
    custOrder.product_price = product.price,
    custOrder.product_quantity = 1,
    custOrder.subtotal = product.price * 1,
    custOrder.taxes = taxes,
    custOrder.total = total,
    custOrder.customer_id = customerId,
    custOrder.order_date = Time.now.strftime("%d/%m/%Y %H:%M")

    custOrder.save
    # CustomerOrder.create(status: "Pending",
    #                       product_name: product.name,
    #                       product_description: product.description,
    #                       product_price: product.price,
    #                       product_quantity: 1,
    #                       subtotal: product.price * 1,
    #                       taxes: taxes,
    #                       total: total,
    #                       customer_id: customerId,
    #                       order_date: Time.now.strftime("%d/%m/%Y %H:%M"))
  end

  private

  def load_taxes(product)
    taxRates = []
    province = Province.find("#{current_customer.address.province_id}")

    if province.pst_rate != 0
      customer_pst_tax = Stripe::TaxRate.create(
        {
          display_name: "PST for #{product.name}",
          inclusive: false,
          percentage: province.pst_rate,
          country: 'CA',
          jurisdiction: province.name,
          description: "#{province.name} Provincial Sales Tax",
        },
      )

      taxRates.push(customer_pst_tax.id)
    end

    if province.gst_rate != 0
      customer_gst_tax = Stripe::TaxRate.create(
        {
          display_name: "GST for #{product.name}",
          inclusive: false,
          percentage: province.gst_rate,
          country: 'CA',
          jurisdiction: province.name,
          description: 'Federal Goods and Services Tax',
        },
      )

      taxRates.push(customer_gst_tax.id)
    end

    if province.hst_rate != 0
      customer_hst_tax = Stripe::TaxRate.create(
        {
          display_name: "HST for #{product.name}",
          inclusive: false,
          percentage: province.hst_rate,
          country: 'CA',
          jurisdiction: province.name,
          description: 'Harmonized Sales Tax',
        },
      )

      taxRates.push(customer_hst_tax.id)
    end

    if province.qst_rate != 0.0
      customer_qst_tax = Stripe::TaxRate.create(
        {
          display_name: "QST for #{product.name}",
          inclusive: false,
          percentage: province.qst_rate,
          country: 'CA',
          jurisdiction: province.name,
          description: 'Quebec Sales Tax',
        },
      )

      taxRates.push(customer_qst_tax.id)
    end

      #@all_taxes = [stripe_customer_pst_tax_id, stripe_customer_gst_tax_id, stripe_customer_hst_tax_id]
      @all_taxes = taxRates
    end

    def shippingRate
      @shipping_rate = Stripe::ShippingRate.create(
        {
          display_name: 'Ground shipping',
          type: 'fixed_amount',
          fixed_amount: {
            amount: 500,
            currency: 'cad',
          },
          delivery_estimate: {
            minimum: {
              unit: 'business_day',
              value: 5,
            },
            maximum: {
              unit: 'business_day',
              value: 7,
            },
          }
        }
      )
    end


end
