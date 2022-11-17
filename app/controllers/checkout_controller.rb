class CheckoutController < ApplicationController
  #before_action :authenticate_customer!
  # before_action :prep_cart

  # def prep_cart
  #   @render_stripe = false
  # end

  def to_builder
    Jbuilder.new do |user|
     user.id id
     user.first_name first_name
     user.last_name  last_name
     user.email  email
     user.profile_photo profile_photo_path
    end
  end

  # def create
  #   @session = Stripe::Checkout::Session.create({
  #     payment_method_types: ['card'],
  #     success_url: root_url,
  #     cancel_url: root_url,
  #     line_items: [
  #       price_data: {
  #         currency: 'cad',
  #         unit_amount: product.price.to_i * 100,
  #         product_data: {
  #           name: product.name,
  #           description: product.description,
  #         },
  #       },
  #       quantity: productOrder.quantity,
  #     ],
  #     mode: 'payment'
  #   })

  #   redirect_to @session.url, allow_other_host: true
  # end

  def create
    product = Product.find(params[:id])
    productOrder = ProductOrder.find_by(product_id: product.id)
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      success_url: order_success_url,
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
      ],
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
