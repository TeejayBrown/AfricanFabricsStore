class UpdateTaxRatesOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :qst_rate, :string
  end
end
