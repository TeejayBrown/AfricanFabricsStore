class ProductCategory < ApplicationRecord
  has_many :products
  validates :name, presence: true, uniqueness: true

  def self.ordered_by_categories
    @product_categories = ProductCategory.select("product_categories.*")
                                      .select("COUNT(product_categories.id) as category_count")
                                      .left_joins(:products)
                                      .group("product_categories.id")
                                      .order("category_count DESC")
  end
end
