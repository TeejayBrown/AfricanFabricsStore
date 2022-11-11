class OrderController < ApplicationController
  def show
    @render_cart = false
  end

  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
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
                              turbo_stream.replace(@product)]
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
                              turbo_stream.replace(@product)]
      end
    end
  end

end
