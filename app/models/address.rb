class Address < ApplicationRecord
  belongs_to :customer
  has_one :province

  validates :street, :city, :postal_code, :customer_id, :province_id, presence: true
end
