class ProductsController < ApplicationController
  # before_action :initialized_session
  # before_action :increment_visit_count, only: %i[index, about]
  # before_action :load_cart

  def index
    @products = Product.all.page params[:page]
  end

  def show
    @product = Product.find(params[:id])
    @display = 1
  end

  def sale
    @products = Product.where(on_sale: true).page params[:page]
  end

  def new
    @products = Product.where(new: true).page params[:page]
  end

  def search
    @products ||= find_products.page params[:page]
  end

  # def add_to_cart
  #   id = params[:id].to_i
  #   qty = params[:quantity].to_i
  #   session[:quantity] << qty
  #   session[:cart] << id unless session[:cart].include?(id)
  #   redirect_to root_path
  # end

  # def remove_from_cart
  #   id = params[:id].to_i
  #   session[:cart].delete(id)
  #   redirect_to root_path
  # end

  # private
  #   def find_products
  #     wildcard_search ="%#{params[:keywords]}%"
  #     products = Product.joins(:product_categories)
  #     products = products.where("name like ?", "%#{params[:keywords]}%") if params[:keywords].present?
  #     products = products.where("product_categories.name like ?", "%#{params[:category]}%") if params[:category].present?
  #     products
  #   end

  #   def initialized_session
  #     session[:visit_count] ||= 0   # Initialize the visit count on first visit.
  #     session[:cart] ||= []
  #     session[:quantity] ||= []
  #   end

  #   def load_cart
  #     @cart = Product.find(session[:cart])
  #     @qty = session[:quantity]
  #   end

  #   def increment_visit_count
  #     session[:visit_count] += 1  # Increment the count with each visit.
  #     @visit_count = session[:visit_count]
  #   end
end
