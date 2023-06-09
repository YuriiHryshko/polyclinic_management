require 'faker'

FactoryBot.define do
    factory :user do
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      email { Faker::Internet.email }
      phone { Faker::Base.numerify('###-###-####') } 
      password { 'password' }
      password_confirmation { 'password' }

      # trait :with_doctor_profile do
      #   association :doctor
      # end
  
      # trait :with_patient_profile do
      #   association :doctor
      # end

    end
end