class AddImageToCustomerOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :customer_orders, :product_image, :string
  end
end
