class Order < ApplicationRecord
  belongs_to :customer

  has_many :product_order
  has_many :products, through: :product_orders

  validates :status, :pst_rate, :gst_rate, :hst_rate,
            :order_date, :sub_total, :total,
            :customer_id, presence: true
  validates :gst_rate, :pst_rate, :hst_rate,
            :total, :sub_total, numericality: true
end
