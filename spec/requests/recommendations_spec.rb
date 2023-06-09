require 'rails_helper'

RSpec::Matchers.define_negated_matcher :not_change, :change


RSpec.describe "Recommendations", type: :request do
  describe "POST /appointments/:appointment_id/recommendations" do
    let(:doctor) { create(:doctor) }
    let(:patient) { create(:patient) }
    let(:appointment) { create(:appointment, doctor: doctor, patient: patient) }

    context "when valid recommendation parameters are provided" do
      let(:recommendation_params) { { text: "Take medicines" } }

      it "creates a new recommendation and updates the appointment status" do
        sign_in doctor.user

        expect {
          post appointment_recommendations_path(appointment_id: appointment.id), params: { recommendation: recommendation_params }
        }.to change(Recommendation, :count).by(1)
         .and change { appointment.reload.status }.from('open').to('closed')

        expect(appointment.reload.recommendation.text).to eq("Take medicines")
        expect(response).to redirect_to(appointment_path(appointment))
        expect(flash[:notice]).to eq("Recommendation was successfully created.")
      end
    end
    context "when invalid recommendation parameters are provided" do
      let(:recommendation_params) { { text: "" } }

      it "will not create a recommendation and will not update the appointment status" do
        sign_in doctor.user

        expect {
          post appointment_recommendations_path(appointment_id: appointment.id), params: { recommendation: recommendation_params }
        }.to not_change(Recommendation, :count)
         .and not_change {appointment.reload.status} .from('open')

        expect(response).to redirect_to(appointment_path(appointment))
        expect(flash[:alert]).to eq("Text can't be blank")
      end
    end
  end
end
