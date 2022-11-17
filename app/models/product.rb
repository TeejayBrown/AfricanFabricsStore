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

  def to_builder
    Jbuilder.new do |product|
      product.name name
      product.description description
    end
  end

  def to_builders
    Jbuilder.new do |product|
      product.currency 'cad'
      product.unit_amount price.to_i * 100
    end
  end
end
