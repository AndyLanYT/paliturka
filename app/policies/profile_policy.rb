class ProfilePolicy < ApplicationPolicy
  def show?
    user
  end

  def update?
    record.user == user if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
