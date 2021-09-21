class LikePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.user != user if user
  end

  def destroy?
    record.user == user if user
  end
end
