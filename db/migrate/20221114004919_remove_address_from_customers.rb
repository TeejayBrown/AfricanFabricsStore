class RemoveAddressFromCustomers < ActiveRecord::Migration[7.0]
  def change
    remove_reference :customers, :address, foreign_key: true
  end
end
