class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy?
    record.user == user || user.admin if user
  end

  def update?
    record.user == user || user.admin if user
  end
end
