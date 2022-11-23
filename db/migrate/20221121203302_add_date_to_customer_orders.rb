class AddDateToCustomerOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :customer_orders, :order_date, :string
  end
end
