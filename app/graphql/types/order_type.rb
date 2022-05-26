module Types
  class OrderType < Types::BaseObject
    field :id, ID, null: false
    field :comment, String, null: true
    field :price, Int, null: false
    field :quantity, Int, null: false
    field :product, ProductType, null: false
    field :user, UserType, null: false
  end
end
