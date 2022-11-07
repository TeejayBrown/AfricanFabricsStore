class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @qty = 1
  end

  def sale
    @products = Product.where(on_sale: true)
  end

  def new
    @products = Product.where(new: true)
  end

  def search
    @products ||= find_products
  end

  private
    def find_products
      wildcard_search ="%#{params[:keywords]}%"
      products = Product.joins(:product_categories)
      products = products.where("name like ?", "%#{params[:keywords]}%") if params[:keywords].present?
      products = products.where("product_categories.name like ?", "%#{params[:category]}%") if params[:category].present?
      products
    end
end
