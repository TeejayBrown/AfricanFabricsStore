ActiveAdmin.register CustomerOrder do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :status, :product_name, :product_description, :product_price, :product_quantity, :subtotal, :taxes, :total, :customer_id, :order_date
  #
  # or
  #
  # permit_params do
  #   permitted = [:status, :product_name, :product_description, :product_price, :product_quantity, :subtotal, :taxes, :total, :customer_id, :order_date]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
