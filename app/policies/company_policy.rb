class CompanyPolicy < ApplicationPolicy
  def update?
    current_user.owner?
  end
end
