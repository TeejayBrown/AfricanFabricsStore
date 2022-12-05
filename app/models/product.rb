class Product < ApplicationRecord
  belongs_to :product_category
  has_many :product_orders
  has_many :orders, through: :product_orders

  has_one_attached :image

  validates :name, :description, :product_category_id, :quantity, :price, presence: true
  paginates_per 3

  def image_as_thumbnail
    image.variant(resize_to_limit: [100, 100]).processed
  end
end
