class CategoryPolicy < ApplicationPolicy
  def index?
    user.present?
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
