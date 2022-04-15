module Types
  class CurrentUserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :avatar_url, String, null: true
    field :confirmed_at, GraphQL::Types::ISO8601DateTime, null: true
    field :birthdate, GraphQL::Types::ISO8601Date, null: true
    field :login, String, null: false
    field :role, String, null: false
    field :bonus_balance, Int, null: false
    field :wallet, Int, null: false

    field :activities, resolver: Resolvers::Activities, connection: true

    delegate :avatar, to: :object
    delegate :url, to: :avatar, prefix: true, allow_nil: true
  end
end
