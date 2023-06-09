ActiveAdmin.register Category do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title

  form do |f|
    f.inputs 'Category Details' do
      f.input :title
    end

    f.actions
  end

  controller do
    def create
      @category = Category.new(permitted_params[:category])

      if @category.save
        redirect_to admin_category_path(@category), notice: 'Category created successfully.'
      else
        render :new
      end
    end

    private

  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:title]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
