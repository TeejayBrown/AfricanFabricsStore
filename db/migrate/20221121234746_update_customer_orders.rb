class UpdateCustomerOrders < ActiveRecord::Migration[7.0]
  def change
    change_column :customer_orders, :product_name, :string, :unique => true
  end
end
