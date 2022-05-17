class InvitationPolicy < ApplicationPolicy
  def create?
    user.owner? || user.manager?
  end
end
