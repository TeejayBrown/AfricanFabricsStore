class ProductCategoriesController < ApplicationController
  def index
    @product_categories = ProductCategory.ordered_by_categories
  end

  def show
    @product_category = ProductCategory.find(params[:id])
  end

end
