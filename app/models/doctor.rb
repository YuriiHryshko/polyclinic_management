class Doctor < ApplicationRecord
    has_and_belongs_to_many :categories, join_table: :doctors_categories
    has_one :user, as: :profile, dependent: :destroy
    has_many :appointments
    has_many :patients, through: :appointments
    accepts_nested_attributes_for :user
    accepts_nested_attributes_for :categories

    delegate :first_name, to: :user
    delegate :last_name, to: :user
    delegate :phone, to: :user
    delegate :email, to: :user
    delegate :full_name, to: :user

    has_one_attached :avatar

end
