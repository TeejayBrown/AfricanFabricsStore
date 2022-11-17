class AddOrderstatusToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :order_status, foreign_key: true
  end
end
