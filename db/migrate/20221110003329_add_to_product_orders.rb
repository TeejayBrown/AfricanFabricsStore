class AddToProductOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :product_orders, :quantity, :integer
  end
end
