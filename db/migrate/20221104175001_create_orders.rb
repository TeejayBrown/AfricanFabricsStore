class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :status
      t.integer :pst_rate
      t.integer :gst_rate
      t.integer :hst_rate
      t.datetime :order_date
      t.decimal :sub_total
      t.decimal :total
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
