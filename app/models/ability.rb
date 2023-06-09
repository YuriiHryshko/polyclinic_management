# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    if user.profile_type == 'Patient'
      can :read, Doctor
      can :manage, Patient, user: user
      can :create, Appointment
      can :read, Appointment, patient: { id: user.profile.id }
      can :read, Recommendation, appointment: { patient: user.profile }
    elsif user.profile_type == 'Doctor'
      can :manage, Doctor, user: user
      can :read, Patient, id: user.profile.patient_ids
      can :read, Appointment, doctor: { id: user.profile.id }
      can :manage, Recommendation, appointment: { doctor: user.profile, status: 0 }
    end
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
