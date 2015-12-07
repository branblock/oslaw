class CommentPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    user.admin?
  end
end
