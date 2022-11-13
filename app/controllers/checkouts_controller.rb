class CheckoutsController < ApplicationController
  before_action :authenticate_customer!

  def show
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

  end
end
