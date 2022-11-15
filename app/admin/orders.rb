ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :order_status_id, :pst_rate, :gst_rate, :hst_rate, :order_date, :sub_total, :total, :customer_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:pst_rate, :gst_rate, :hst_rate, :order_date, :sub_total, :total, :order_status_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # form do |f|
  #   # f.semantic_errors *f.object.errors.keys

  #   # need to pull taxes from db
  #   f.inputs 'Order' do
  #     f.input :order_date
  #     f.input :customer
  #     f.input :pst_rate
  #     f.input :gst_rate
  #     f.input :hst_rate
  #     f.input :order_status
  #     f.input :sub_total
  #     f.input :total

  #     # f.has_many :order_items, allow_destroy: true do |n_f|
  #     #   n_f.input :tour
  #     # end
  #   end
  #   f.actions
  # end

end
