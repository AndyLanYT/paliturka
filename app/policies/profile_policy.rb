class ProfilePolicy < ApplicationPolicy
  def show?
    record.user == user || user.admin || !record.hidden if user
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
