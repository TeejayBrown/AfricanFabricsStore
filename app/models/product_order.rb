class ProductOrder < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def subtotal
    product.price * quantity
  end

  def to_builder
    Jbuilder.new do |productOrder|
      productOrder.price_data product.to_builders
      # productOrder.currency 'cad'
      # productOrder.unit_amount product.price.to_i * 100
      # productOrder.name product.name
      # productOrder.description product.description
      # productOrder.quantity quantity
      productOrder.product_data product.to_builder
      productOrder.quantity quantity
    end


  end

  # def to_builder
  #   Jbuilder.new do |productOrder|
  #     productOrder.price_data product.to_builders
  #     # productOrder.currency 'cad'
  #     # productOrder.unit_amount product.price.to_i * 100
  #     # productOrder.name product.name
  #     # productOrder.description product.description
  #     # productOrder.quantity quantity
  #     productOrder.product_data product.to_builder
  #     productOrder.quantity quantity
  #   end
  # end

  # after_create do
  #   product = Stripe::Product.create(name: name)
  #   price = Stripe::Price.create(product: product, unit_amount: self.price, currency: self.currency)
  #   update(stripe_product_id: product.id, stripe_price_id: price.id)
  # end

  # def to_builder
  #   Jbuilder.new do |productOrder|
  #     productOrder.currency 'cad'
  #     productOrder.unit_amount product.price.to_i * 100
  #     # productOrder.name product.name
  #     # productOrder.description product.description
  #     # productOrder.quantity quantity
  #   end
  # end

  def line_items
    @order.product_orders.each do |productOrder|
      product = productOrder.product
      line_items.push({
        price_data: {
          currency: 'cad',
          unit_amount: product.price.to_i * 100,
          product_data: {
            name: product.name,
            description: product.description
          },
        },
        quantity: productOrder.quantity,
      })
    end
  end



end
