class DropCustomers < ActiveRecord::Migration[7.0]
  def up
    drop_table :customers
  end
end
