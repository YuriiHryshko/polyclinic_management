class PatientsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource  
  before_action :set_patient, only: [:update, :destroy, :edit]

  def show
    @patient = Patient.find(params[:id])
  end

  def edit
  end

  def destroy
    @patient.destroy
    redirect_to root_path, notice: 'Patient was successfully deleted.'
  end

  def update
    if @patient.user.update(patient_params)
      redirect_to @patient, notice: 'Patient was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :phone, :email)
  end

end
