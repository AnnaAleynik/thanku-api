module Types
  module Payloads
    class AcceptInvitationPayload < Types::BaseObject
      field :me, Types::CurrentUserType, null: false, method: :user
    end
  end
end
