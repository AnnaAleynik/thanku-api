module Types
  module Payloads
    class OrderPayload < Types::BaseObject
      field :order, Types::OrderType, null: true
      field :me, Types::CurrentUserType, null: false, method: :current_user
    end
  end
end
