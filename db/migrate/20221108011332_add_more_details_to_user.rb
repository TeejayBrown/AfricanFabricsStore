class AddMoreDetailsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :street, :string
    add_column :users, :city, :string
  end
end
