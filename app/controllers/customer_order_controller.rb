class CustomerOrderController < ApplicationController
  def show
    @customer_orders = CustomerOrder.where(customer_id: current_customer.id)
  end
end
