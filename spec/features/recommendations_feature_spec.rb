# spec/features/doctor_creates_recommendation_spec.rb

require 'rails_helper'

RSpec.feature 'Doctor creates recommendation', type: :feature do
  let(:doctor) { FactoryBot.create(:doctor) }
  let(:patient) { FactoryBot.create(:patient) }
  let(:appointment) { FactoryBot.create(:appointment, doctor: doctor, patient: patient) }

  context 'Doctor creates recommendation for an appointment' do
    scenario "should be successful" do
        sign_in(doctor.user)

        visit appointment_path(appointment)

        expect(page).to have_content('Open') # status
        expect(page).to have_field('Recommendation Text')

        fill_in 'Recommendation Text', with: 'This is my recommendation for the patient.'
        click_button 'Create Recommendation'

        expect(page).to have_content('Doctor\'s recommendation')
        expect(page).to have_content('This is my recommendation for the patient.')
        expect(page).to have_content('Closed')
    end
    scenario "should fail" do
        sign_in(doctor.user)

        visit appointment_path(appointment)

        expect(page).to have_content('Open') # status
        expect(page).to have_field('Recommendation Text')

        fill_in 'Recommendation Text', with: ''
        click_button 'Create Recommendation'

        expect(page).to have_content('Open')
        expect(page).to have_content('Text can\'t be blank')
        expect(page).to have_field('Recommendation Text')
    end

  end

  def sign_in(user)
    visit new_user_session_path
    fill_in 'Phone', with: user.phone
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end
end
