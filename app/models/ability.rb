class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      alias_action :create, :read, :update, :destroy, to: :crud
      #
      user ||= User.new # guest user (not logged in)
      if user.type=="Administrator"
        can :manage, :all           # grant access to all app ressources
        can :access, :rails_admin   # grant access to rails_admin
        can :dashboard              # grant access to the dashboard
      elsif user.type=="Employee"
        can :crud, Receipt
        can :crud, Order
      else
        cannot :manage, :all
        # cannot :crud, User
      end
    #
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
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
