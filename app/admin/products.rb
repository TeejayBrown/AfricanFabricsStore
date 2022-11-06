ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :price, :on_sale, :new, :product_category_id, :quantity, :image

  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      # f.input :product_category_id, as: :select, collection: ProductCategory.all
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image) : ""
    end
    f.actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :price_cents, :on_sale, :new, :product_category_id, :quantity]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
