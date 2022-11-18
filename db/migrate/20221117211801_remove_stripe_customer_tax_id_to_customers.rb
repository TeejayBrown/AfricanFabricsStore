class RemoveStripeCustomerTaxIdToCustomers < ActiveRecord::Migration[7.0]
  def change
    remove_column :customers, :stripe_customer_tax_id, :string
  end
end
