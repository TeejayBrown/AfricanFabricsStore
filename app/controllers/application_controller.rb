class ApplicationController < ActionController::Base
  before_action :set_render_cart
  before_action :initialize_cart
  #helper_method :cart

  def set_render_cart
    @render_cart = true
  end

  def initialize_cart
    session[:order_id] ||= []
    #@cart = Order.where(id: session[:cart])
    @order ||= Order.find_by(id: session[:order_id])

    if @order.nil?
      @order = Order.create
      #@order = Order.new #Order.create
      session[:order_id] = @order.id

    end
  end
end
