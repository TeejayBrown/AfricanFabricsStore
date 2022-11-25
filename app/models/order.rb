class Order < ApplicationRecord
  #belongs_to :customer

  has_many :product_orders, dependent: :destroy
  has_many :products, through: :product_orders
  accepts_nested_attributes_for :product_orders, allow_destroy: true

  # validates :pst_rate, :gst_rate, :hst_rate, :qst_rate,
  #           :order_date, :sub_total, :total,presence: true

  def subtotal
    product_orders.to_a.sum { |product_order| product_order.subtotal }
  end

end
