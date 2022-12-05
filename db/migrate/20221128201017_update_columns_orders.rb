class UpdateColumnsOrders < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :pst_rate, :integer, :null => true
    change_column :orders, :gst_rate, :integer, :null => true
    change_column :orders, :hst_rate, :integer, :null => true
    change_column :orders, :qst_rate, :integer, :null => true
    change_column :orders, :order_date, :datetime, :null => true
    change_column :orders, :sub_total, :decimal, :null => true
    change_column :orders, :total, :decimal, :null => true
  end
end
