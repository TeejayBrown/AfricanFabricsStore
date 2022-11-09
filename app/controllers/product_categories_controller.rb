class ProductCategoriesController < ApplicationController
  def index
    @product_categories = ProductCategory.ordered_by_categories
  end

  def show
    @product_category = ProductCategory.find(params[:id])
  end

  def ankara
    @product_category = ProductCategory.find("1") #.where(name: "Ankara")
  end

  def adire
    @product_category = ProductCategory.find("2") #.where(name: "Ankara")
  end

  def asooke
    @product_category = ProductCategory.find("3") #.where(name: "Ankara")
  end

  def lace
    @product_category = ProductCategory.find("4") #.where(name: "Ankara")
  end

end
