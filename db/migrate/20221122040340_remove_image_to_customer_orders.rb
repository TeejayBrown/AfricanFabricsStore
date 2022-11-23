class RemoveImageToCustomerOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :customer_orders, :product_image, :string
  end
end
