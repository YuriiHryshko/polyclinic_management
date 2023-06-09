FactoryBot.define do
    factory :appointment do
      status { 0 }
      association :doctor
      association :patient
    end
  end