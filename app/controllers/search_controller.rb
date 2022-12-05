class SearchController < ApplicationController
  def index
    @query = params[:q]
    if params[:category].blank?
      @searched_items = Product.where("name LIKE ? or description LIKE ?",
                                      "%#{@query}%", "%#{@query}%")
    else
      category = ProductCategory.find(params[:category])
      @searched_items = category.products.where("name LIKE ? or description LIKE ?",
                                                "%#{@query}%", "%#{@query}%")
    end
  end

  # def index
  #   @searched_items ||= find_products
  # end

  private

  def find_products
    wildcard_search = "%#{params[:keywords]}%"
    searched_items = ProductCategory.joins(:products)
    if params[:keywords].present?
      searched_items = searched_items.where("products.name like ?",
                                            "%#{params[:keywords]}%")
    end
    if params[:category].present?
      searched_items = searched_items.where("product_categories.name like ?",
                                            "%#{params[:category]}%")
    end
    searched_items
  end
end
