class AddReferenceToAddress < ActiveRecord::Migration[7.0]
  def change
    add_reference :addresses, :province, foreign_key: true
  end
end
