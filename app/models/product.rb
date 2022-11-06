class Product < ApplicationRecord
  belongs_to :product_category

  has_one_attached :image

  validates :name, :description, :product_category_id, :quantity, :price, presence: true

end
