class CustomerOrder < ApplicationRecord
  belongs_to :customer

  # validates :status, :product_name, :product_description, :product_price, :product_quantity,
  #           :subtotal, :taxes, :total, :customer_id, :order_date, presence: true
  validates :product_name, uniqueness: true
end
