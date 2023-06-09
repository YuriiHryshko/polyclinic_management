class Recommendation < ApplicationRecord
    belongs_to :appointment
    after_create :change_appointment_status
    validates :text, presence: true

    private
      def change_appointment_status
        appointment.update(status: 1)
      end
end
