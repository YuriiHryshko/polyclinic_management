class AppointmentsController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource
    before_action :set_appointment, only: [:show, :edit, :destroy]

    def create
        @appointment = Appointment.new(appointment_params)
    
        if @appointment.save
          redirect_to @appointment, notice: 'Appointment was successfully created.'
        else
          redirect_to @appointment.doctor, alert: "#{@appointment.errors.full_messages.to_sentence}"
        end
    end

    def new
        @appointment = Appointment.new
    end

    def destroy
        @appointment.destroy
        redirect_to appointments_path, notice: 'Appointment was successfully destroyed.'
    end

    def index
        @appointments = Appointment.accessible_by(current_ability).order(created_at: :desc)
        if params[:status].present?
            @appointments = @appointments.where(status: params[:status]).order(created_at: :desc)
        end
    end


    private

    def appointment_params
        params.require(:appointment).permit(:doctor_id, :patient_id)
    end

    def set_appointment
        @appointment = Appointment.find(params[:id])
    end
end
