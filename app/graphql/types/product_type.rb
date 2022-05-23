module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :price, Int, null: false
    field :count, Int, null: false
    field :picture_url, String, null: true
  end
end
