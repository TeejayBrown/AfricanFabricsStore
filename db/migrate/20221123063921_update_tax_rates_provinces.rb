class UpdateTaxRatesProvinces < ActiveRecord::Migration[7.0]
  def change
    add_column :provinces, :qst_rate, :decimal
  end
end
