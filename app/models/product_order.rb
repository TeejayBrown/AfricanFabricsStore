class ProductOrder < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def subtotal
    product.price * quantity
  end
end
