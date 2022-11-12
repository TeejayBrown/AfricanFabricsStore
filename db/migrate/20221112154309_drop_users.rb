class DropUsers < ActiveRecord::Migration[7.0]
  def up
    drop_table :users
  end
end
