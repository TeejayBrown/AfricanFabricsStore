class UpdateDataPages < ActiveRecord::Migration[7.0]
  def up
    change_column :pages, :description, :text
  end

  def down
    change_column :pages, :description, :string
  end
end
