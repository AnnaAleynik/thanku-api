class UserPolicy < ApplicationPolicy
  def create_product?
    user.owner? || user.manager?
  end
end
