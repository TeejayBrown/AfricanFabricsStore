class RemovedToUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :email, :string
    remove_column :users, :encrypted_password, :string
    remove_column :users, :reset_password_token, :string
    remove_column :users, :first_name, :string
    remove_column :users, :middle_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :salt, :string
    remove_column :users, :address, :string
    remove_column :users, :postal_code, :string
    remove_column :users, :street, :string
    remove_column :users, :city, :string
  end
end
