module Types
  module Payloads
    class InviteUserPayload < Types::BaseObject
      field :invited_user, Types::UserType, null: true, method: :user
    end
  end
end
