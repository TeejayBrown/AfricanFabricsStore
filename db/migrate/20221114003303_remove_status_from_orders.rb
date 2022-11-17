class RemoveStatusFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_reference :orders, :order_status, foreign_key: true
  end
end
