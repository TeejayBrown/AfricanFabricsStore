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

  def clamp(min, max)
    self < min ? min : self > max ? max : self
  end

  private

  def initialized_quantity
    @qty ||= 0   # Initialize the visit count on first visit.
  end
end
