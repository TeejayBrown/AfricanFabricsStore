class AddDetailsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
    add_column :users, :salt, :string
    add_column :users, :address, :string
    add_column :users, :postal_code, :string
    add_reference :users, :province, foreign_key: true
  end
end
