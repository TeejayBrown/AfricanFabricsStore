class CreateCustomerOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_orders do |t|
      t.string :status
      t.string :product_name
      t.string :product_description
      t.decimal :product_price
      t.integer :product_quantity
      t.decimal :subtotal
      t.decimal :taxes
      t.decimal :total
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
