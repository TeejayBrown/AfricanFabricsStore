# Product.destroy_all
Order.destroy_all
#CustomerOrder.destroy_all
if Rails.env.development?
  AdminUser.create!(email: "admin@taiwoomoleye.com", password: "Shulamite101#",
                    password_confirmation: "Shulamite101#")
end
