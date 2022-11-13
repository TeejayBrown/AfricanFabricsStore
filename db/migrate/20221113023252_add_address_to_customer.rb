class AddAddressToCustomer < ActiveRecord::Migration[7.0]
  def change
    add_reference :customers, :address, foreign_key: true
  end
end
