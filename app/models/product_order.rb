class ProductOrder < ApplicationRecord
  belongs_to :product
  belongs_to :order

  # def sub_total
  #   product.price * quantity
  # end

  def total
    product.price * quantity
  end
end
