ActiveAdmin.register Doctor do
  permit_params :avatar, user_attributes: [:id, :first_name, :last_name, :phone, :email, :password, :password_confirmation], category_ids: []

  filter :categories
  filter :created_at

  index do
    selectable_column
    column :id
    column :first_name 
    column :last_name 
    column :email 
    column :phone

    column :categories do |doctor|
      doctor.categories.each do |category|
        category.title
      end
    end
  
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :first_name 
      row :last_name 
      row :phone 
      row :email
      # row :email do |patient|
      #   patient.user.email
      # end
      row :categories do |doctor|
        doctor.categories.each do |category|
          category.title
        end
      end
      row :created_at
      # Add more rows as needed
    end
  end
  
  form do |f| 
    if object.new_record?
      f.inputs 'Doctor Details' do
        f.object.build_user if f.object.user.nil? # Build the user association if not already present
        f.fields_for :user do |user_fields|
          user_fields.input :first_name
          user_fields.input :last_name
          user_fields.input :phone
          user_fields.input :email
          user_fields.input :password
          user_fields.input :password_confirmation
        end
        f.input :categories, as: :select, collection: Category.all, multiple: true
        f.input :avatar, as: :file
      end 
    else
      f.inputs 'User Details', for: [:user, f.object.user] do |u|
        u.input :first_name, as: :string, input_html: { value: u.object.first_name }
        u.input :last_name, as: :string, input_html: { value: u.object.last_name }
        u.input :phone, as: :string, input_html: { value: u.object.phone }
        u.input :email, as: :string, input_html: { value: u.object.email }
      end
      f.input :categories, as: :select, collection: Category.all, multiple: true
    end
    f.actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  controller do
    def create
      @doctor = Doctor.new()
      @doctor.category_ids = permitted_params[:doctor][:category_ids]
      @user = User.new(permitted_params[:doctor][:user_attributes]) # Build the associated user with the provided user params
      @user.profile = @doctor
      @doctor.user = @user
      @doctor.avatar.attach(permitted_params[:doctor][:avatar]) # Attach the uploaded avatar to the user

      if @doctor.save and @user.save
        redirect_to admin_doctor_path(@doctor), notice: 'Doctor created successfully.'
      else
        flash.now[:error] = @doctor.user.errors.full_messages.to_sentence
        render :new
      end
    end

    def update
      @doctor = Doctor.find(params[:id])
      @doctor.category_ids = permitted_params[:doctor][:category_ids]
      if @doctor.user.update(permitted_params[:doctor][:user_attributes])
        redirect_to admin_doctor_path(@doctor), notice: 'Doctor updated successfully.'
      else
        flash.now.error = @doctor.user.errors.full_messages.to_sentence
        render :edit
      end
    end

  end
  # permit_params 
  #
  # or
  #
  # permit_params do
  #   permitted = []
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
