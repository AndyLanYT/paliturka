class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user
  end

  def show?
    user
  end

  def create?
    user
  end

  def update?
    record.user == user if user
  end

  def destroy?
    record.user == user || record.post.user == user || user.admin if user
  end
end
