class Patient < ApplicationRecord
    has_one :user, as: :profile, dependent: :destroy
    has_many :appointments, dependent: :destroy
    has_many :doctors, through: :appointments
    accepts_nested_attributes_for :user

    delegate :first_name, to: :user
    delegate :last_name, to: :user
    delegate :phone, to: :user
    delegate :email, to: :user
    delegate :full_name, to: :user


end
