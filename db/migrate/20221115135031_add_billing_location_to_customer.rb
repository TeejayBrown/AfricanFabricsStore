class AddBillingLocationToCustomer < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :city, :string
    add_column :customers, :country, :string
  end
end
