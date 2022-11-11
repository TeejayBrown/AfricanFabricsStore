class AddColumnFromOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :pst_rate, :string
    add_column :orders, :gst_rate, :string
    add_column :orders, :hst_rate, :string
    add_column :orders, :order_date, :string
    add_column :orders, :sub_total, :string
    add_column :orders, :total, :string
  end
end
