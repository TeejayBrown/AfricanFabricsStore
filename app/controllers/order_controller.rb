class OrderController < ApplicationController
  #before_action :initialize_cart

  def show
    @render_cart = false
    @show_cart = 1

    # @order.product_orders.each do |entry|
    #   @orderlist << {
    #     :name => entry.product.name,
    #     :description => entry.product.description,
    #     :price => entry.product.price,
    #     :quantity => entry.quantity
    #   }
    # end
  end

  def add
    id = params[:id].to_i
    #session[:order_id] << id
    @product = Product.find_by(id: params[:id])
    #id = params[:id].to_i
    session[:order_id] << id #unless session[:order_id].include?(id)
    quantity = params[:quantity].to_i
    flash.now[:notice] = "#{quantity} Item(s) added to cart"
    current_product_order = @order.product_orders.find_by(product_id: @product.id)
    if current_product_order && quantity > 0
      current_product_order.update(quantity:)
    elsif quantity <= 0
      current_product_order.destroy
    else
      @order.product_orders.create(product: @product, quantity:)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('order',
                                                   partial: 'order/order',
                                                   locals: { order: @order }),
                              turbo_stream.replace('show_order',
                                partial: 'order/show_orders',
                                locals: { order: @order }),
                              turbo_stream.replace('show_notice',
                                partial: 'common/alerts')]
      end
    end
  end

  def remove
    ProductOrder.find_by(id: params[:id]).destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [turbo_stream.replace('order',
                                                   partial: 'order/order',
                                                   locals: { order: @order }),
                              turbo_stream.replace('show_order',
                                                    partial: 'order/show_orders',
                                                    locals: { order: @order })]
      end
    end
  end

  # def initialize_cart
  #   @order ||= Order.find_by(id: session[:order_id])

  #   if @order.nil?
  #     @order = Order.create
  #     session[:order_id] = @order.id
  #   end

  # end

end
