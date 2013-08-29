class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.blogger?
      can :manage, Post
      can :manage, Show, :user_id => user.id
      cannot [:create,:new,:edit,:update,:destroy], Podcast
    elsif user.dj?
      can :manage, Show, :user_id => user.id
      cannot [:create,:new,:edit,:update,:destroy], Podcast
    end
    can :read, Podcast
    can :read, Show
    can :read, Post
    can :show, User
  end
end
