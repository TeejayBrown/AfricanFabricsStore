class AddStripeCustomerTaxIdToAddresses < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :stripe_customer_tax_id, :string
  end
end
