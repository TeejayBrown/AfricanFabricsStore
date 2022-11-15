class RemoveCustomerFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_reference :orders, :customer, foreign_key: true
  end
end
