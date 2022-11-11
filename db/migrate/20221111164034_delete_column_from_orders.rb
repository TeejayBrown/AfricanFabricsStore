class DeleteColumnFromOrders < ActiveRecord::Migration[7.0]
  def change
    # remove_column :orders, :pst_rate, :string
    # remove_column :orders, :gst_rate, :string
    # remove_column :orders, :hst_rate, :string
    # remove_column :orders, :order_date, :string
    # remove_column :orders, :sub_total, :string
    # remove_column :orders, :total, :string
    remove_column :orders, :status, :string
  end
end
