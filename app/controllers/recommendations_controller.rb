class RecommendationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment
  before_action :set_recommendation, only: [:edit, :update, :destroy, :new]

  def create
    @recommendation = Recommendation.new(recommendation_params)
    @recommendation.appointment = @appointment

    if @recommendation.save
      redirect_to @appointment, notice: 'Recommendation was successfully created.'
    else
      redirect_to @appointment, alert: "#{@recommendation.errors.full_messages.to_sentence}"
    end
  end

  def new
    @recommendation = Recommendation.new
  end


  def update
    if @recommendation.update(recommendation_params)
      redirect_to @appointment, notice: 'Recommendation was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @recommendation.destroy
    redirect_to @appointment, notice: 'Recommendation was successfully destroyed.'
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:appointment_id])
  end

  def set_recommendation
    @recommendation = @appointment.recommendation
  end

  def recommendation_params
    params.require(:recommendation).permit(:text)
  end
end