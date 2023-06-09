FactoryBot.define do
    factory :patient do
        user { association :user }
    end
  end