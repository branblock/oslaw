class PostPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    user.present?
  end

  def update?
    user.present? && (record.user == user || user.admin?)
  end

  def show?
    create?
  end

  def destroy?
    user.present? && user.admin?
  end
end
