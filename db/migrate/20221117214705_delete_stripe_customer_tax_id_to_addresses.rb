class DeleteStripeCustomerTaxIdToAddresses < ActiveRecord::Migration[7.0]
  def change
    remove_column :addresses, :stripe_customer_tax_id, :string
  end
end
