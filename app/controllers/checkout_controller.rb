class CheckoutController < ApplicationController
  before_action :authenticate_customer!
  # before_action :prep_cart

  def pay
    product = Product.find(params[:id])
    productOrder = ProductOrder.find_by(product_id: product.id)

    customer_tax = Stripe::TaxRate.create(
      {
        display_name: 'PST',
        inclusive: false,
        percentage: 7.25,
        country: 'CA',
        jurisdiction: 'US - CA',
        description: 'CA Sales Tax',
      },
    )

    stripe_customer_tax_id = customer_tax.id

    @session = Stripe::Checkout::Session.create({
      customer: current_customer.stripe_customer_id,
      payment_method_types: ['card'],
      success_url: order_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: root_url,
      line_items: [
        price_data: {
          currency: 'cad',
          unit_amount: product.price.to_i * 100,
          product_data: {
            name: product.name,
            description: product.description,
          },
        },
        quantity: productOrder.quantity,
        tax_rates: [stripe_customer_tax_id],
      ],
      mode: 'payment'
    })


    redirect_to @session.url, allow_other_host: true
  end

  def create
    lineItems = []
    taxRates = []
    @order.product_orders.each do |productOrder|
      product = productOrder.product
      province = Province.find("#{current_customer.address.province_id}")
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
      stripe_customer_pst_tax_id = customer_pst_tax.id

      if province.pst_rate != 0
        taxRates.push(stripe_customer_pst_tax_id)
      end

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
      stripe_customer_gst_tax_id = customer_gst_tax.id

      if province.gst_rate != 0
        taxRates.push(stripe_customer_gst_tax_id)
      end

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
      stripe_customer_hst_tax_id = customer_hst_tax.id

      # stripe_customer_pst_tax_id ||= customer_pst_tax.id if province.pst_rate
      # stripe_customer_gst_tax_id ||= customer_gst_tax.id  if province.gst_rate

      if province.hst_rate != 0
        taxRates.push(stripe_customer_hst_tax_id)
      end

      lineItems.push({
        price_data: {
          currency: 'cad',
          unit_amount: product.price.to_i * 100,
          product_data: {
            name: product.name,
            description: product.description
          },
        },
        quantity: productOrder.quantity,
        tax_rates: [stripe_customer_pst_tax_id, stripe_customer_gst_tax_id, stripe_customer_hst_tax_id],
        #tax_rates: taxRates #[stripe_customer_pst_tax_id if province.pst_rate!, stripe_customer_gst_tax_id if province.gst_rate!, stripe_customer_hst_tax_id if province.hst_rate!],
        })
    end

    @session = Stripe::Checkout::Session.create({
      # automatic_tax: { enabled: true },
      customer: current_customer.stripe_customer_id,
      payment_method_types: ['card'],
      success_url: order_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: root_url,
      line_items: lineItems,
      mode: 'payment'
    })

    redirect_to @session.url, allow_other_host: true
  end

  def show
    #@render_cart = false
    # current_customer.set_payment_processor :stripe
    # current_customer.payment_processor.customer

    # @checkout_session = current_customer
    #     .payment_processor
    #     .checkout(
    #         mode: 'payment',
    #         line_items: '',
    #         success_url: checkout_success_url,
    #     )
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end
end
