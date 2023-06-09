require "rails_helper"

RSpec.describe User, type: :model do
    describe 'validations' do
        context 'phone number validation' do
            it 'will be not valid' do
                user = build(:user, phone: '673487845')

                expect(user).not_to be_valid
                expect(user.errors[:phone]).to include('- Phone numbers must be in xxx-xxx-xxxx format.')
            end

            it 'will be valid' do
                user = build(:user)

                expect(user).to be_valid
            end
        end
    end
end