class RemoveDetailsToUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :first_name, :string
    remove_column :users, :miidle_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :salt, :string
    remove_column :users, :address, :string
    remove_column :users, :postal_code, :string
  end
end
