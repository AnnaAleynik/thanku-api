module Types
  module Payloads
    class ProductPayload < Types::BaseObject
      field :product, Types::ProductType, null: true
    end
  end
end
