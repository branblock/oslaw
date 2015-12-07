class UserPolicy < ApplicationPolicy
  def destroy?
    user.present? && user.admin?
  end
end
