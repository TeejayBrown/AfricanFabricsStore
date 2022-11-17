class RemoveBillingLocationToCustomer < ActiveRecord::Migration[7.0]
  def change
    remove_column :customers, :city, :string
    remove_column :customers, :country, :string
  end
end
