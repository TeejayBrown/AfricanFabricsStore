class RemoveReferenceToUser < ActiveRecord::Migration[7.0]
  def change
    remove_reference :users, :province, foreign_key: true
  end
end
