class UserPolicy < ApplicationPolicy
  def index?
    user.present? && user.admin?
  end

  def show?
    user.present?
  end

  def destroy?
    user.present? && user.admin?
  end
end
