class AddPriceToProductOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :product_orders, :price, :decimal, precision: 5, scale: 2
  end
end
