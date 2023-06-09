class User < ApplicationRecord

  after_create :create_patient, unless: :profile_exists?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :phone, uniqueness: true

  validates_format_of :phone,
  :with => /\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/,
  :message => "- Phone numbers must be in xxx-xxx-xxxx format."

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :profile, polymorphic: true, optional: true, dependent: :destroy


  def profile_exists?
    profile.present?
  end

  def full_name
    "#{first_name} #{last_name}" 
  end

  def is_a_doctor?
    profile_type == 'Doctor'
  end

  def is_a_patient?
    profile_type == 'Patient'
  end


  # def email_required?
  #   false
  # end
  
  def email_changed?
    false
  end

  private
    def create_patient
      patient = Patient.create()
      self.profile = patient
      patient.user = self
    end
end
