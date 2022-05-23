module Types
  module Payloads
    class CreateProductPayload < Types::BaseObject
      field :product, Types::ProductType, null: true
    end
  end
end
