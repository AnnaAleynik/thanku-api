module Types
  module Payloads
    class SendBonusPayload < Types::BaseObject
      field :bonus_transfer, Types::BonusTransferType, null: true
    end
  end
end
