class Order < ApplicationRecord
  belongs_to :customer

  has_many :product_orders
  has_many :products, through: :product_orders

  # validates :status, :pst_rate, :gst_rate, :hst_rate,
  #           :order_date, :sub_total, :total,
  #           :customer_id, presence: true
  # validates :gst_rate, :pst_rate, :hst_rate,
  #           :total, :sub_total, numericality: true

  def total
    product_orders.to_a.sum { |product_order| product_order.total }
  end
end
