module Types
  class QueryType < Types::BaseObject
    field :me, resolver: Resolvers::CurrentUser
    field :activities, resolver: Resolvers::Activities, connection: true
    field :users, resolver: Resolvers::Users, connection: true
    field :products, resolver: Resolvers::Products, connection: true
  end
end
