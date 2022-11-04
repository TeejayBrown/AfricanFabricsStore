class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :price_cents
      t.string :image
      t.boolean :on_sale
      t.boolean :new
      t.references :product_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
