class ApplicationController < ActionController::Base
  before_action :set_render_cart
  before_action :initialize_cart

  def set_render_cart
    @render_cart = true
  end

  def initialize_cart
    @order ||= Order.find_by(id: session[:order_id])

    if @order.nil?
      @order = Order.create
      session[:order_id] = @order.id
    end
  end
end
