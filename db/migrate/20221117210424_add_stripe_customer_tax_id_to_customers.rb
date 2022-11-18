class AddStripeCustomerTaxIdToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :stripe_customer_tax_id, :string
  end
end
