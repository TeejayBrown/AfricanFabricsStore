class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #pay_customer stripe_attributes: :stripe_attributes
  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false }

  def full_name
    "#{first_name.capitalize unless first_name.nil?} #{last_name.capitalize unless last_name.nil?}"
  end

  def stripe_attributes(pay_customer)
    {
      address: {
        city: pay_customer.owner.city,
        country: pay_customer.owner.country
      },
      metada: {
        pay_customer_id: pay_customer.id,
        customer_id: id
      }
    }
  end
end
