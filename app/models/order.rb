class Order < ApplicationRecord
  #belongs_to :customer

  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders
  accepts_nested_attributes_for :product_orders, allow_destroy: true

  # validates :status, :pst_rate, :gst_rate, :hst_rate,
  #           :order_date, :sub_total, :total,
  #           :customer_id, presence: true
  # validates :gst_rate, :pst_rate, :hst_rate,
  #           :total, :sub_total, numericality: true

  def subtotal
    product_orders.to_a.sum { |product_order| product_order.subtotal }
  end

  # def to_builder
  #   Jbuilder.new do |pOrder|
  #     pOrder.price_data price_data.to_builder
  #     # productOrder.name product.name
  #     # productOrder.description product.description
  #     # productOrder.quantity quantity
  #   end
  # end
  # def to_builder
  #   Jbuilder.new do |order|
  #     order.currency 'cad'
  #     order.unit_amount product.price.to_i * 100
  #   end
  # end

end
