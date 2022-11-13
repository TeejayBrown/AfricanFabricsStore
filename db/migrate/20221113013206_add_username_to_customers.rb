class AddUsernameToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :username, :string, index: true, unique: true
    add_column :customers, :last_name, :string
  end
end
