module Types
  class BonusTransferType < Types::BaseObject
    field :id, ID, null: false
    field :sender, Types::UserType, null: false
    field :receiver, Types::UserType, null: false
    field :comment, String, null: false
    field :amount, Integer, null: false
    field :parent_id, ID, null: true
    field :bonus_transfers, [Types::BonusTransferType], null: true
  end
end
