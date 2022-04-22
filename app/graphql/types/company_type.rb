module Types
  class CompanyType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :bonus_amount, Int, null: false
    field :owner, Types::UserType, null: true
  end
end
