class ProductCategoriesController < ApplicationController
  def index
    @product_categories = ProductCategory.ordered_by_categories
  end

  def show
    @product_category = ProductCategory.find(params[:id])
  end

  def ankara
    @product_category = ProductCategory.find_by(name: "Ankara")
  end

  def adire
    @product_category = ProductCategory.find_by(name: "Adire")
  end

  def asooke
    @product_category = ProductCategory.find_by(name: "AsoOke")
  end

  def lace
    @product_category = ProductCategory.find_by(name: "Lace")
  end
end
