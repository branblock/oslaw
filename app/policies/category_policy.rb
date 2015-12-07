class CategoryPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present? && user.admin?
  end

  def update?
    user.present? && user.admin?
  end

  def show?
    user.present?
  end

  def destroy?
    user.present? && user.admin?
  end
end
