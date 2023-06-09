FactoryBot.define do
    factory :doctor do
      user { association :user }
    end
  end