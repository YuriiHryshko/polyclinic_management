ActiveAdmin.register Patient do

  permit_params user_attributes: [:first_name, :last_name, :phone, :email, :password, :password_confirmation]

  filter :user_first_name, as: :string, label: 'First name'
  filter :user_last_name, as: :string, label: 'Last name'
  filter :created_at

  index do
    selectable_column
    column :id
    column :first_name 
    column :last_name 
    column :email 
    column :phone 
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
      row :created_at
    end
  end

  form do |f|
    if object.new_record?
      f.inputs 'Patient Details' do
      f.object.build_user if f.object.user.nil? 
      f.fields_for :user do |user_fields|
        user_fields.input :first_name
        user_fields.input :last_name
        user_fields.input :phone
        user_fields.input :email
        user_fields.input :password
        user_fields.input :password_confirmation
      end
    end
    else
      f.inputs 'User Details', for: [:user, f.object.user] do |u|
        u.input :first_name, as: :string, input_html: { value: u.object.first_name }
        u.input :last_name, as: :string, input_html: { value: u.object.last_name }
        u.input :phone, as: :string, input_html: { value: u.object.phone }
        u.input :email, as: :string, input_html: { value: u.object.email }
      end
    end
    f.actions
  end

  controller do
    def update
      @patient = Patient.find(params[:id])
      if @patient.user.update(permitted_params[:patient][:user_attributes]) 
        redirect_to admin_patient_path(@patient), notice: 'Patient updated successfully.'
      else
        flash.now.error = @patient.user.errors.full_messages.to_sentence
        render :edit
      end
    end
    def create
      @patient = Patient.new()
      @user = User.new(permitted_params[:patient][:user_attributes])
      @user.profile = @patient
      @patient.user = @user
      if @patient.save and @user.save
        redirect_to admin_patient_path(@patient), notice: 'Patient created successfully.'
      else
        flash.now[:error] = @patient.user.errors.full_messages.to_sentence
        render :new
      end
    end

  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
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
