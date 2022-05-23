class UserPolicy < ApplicationPolicy
  def manage_product?
    user.owner? || user.manager?
  end
end
