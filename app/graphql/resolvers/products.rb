module Resolvers
  class Products < Resolvers::Base
    include AuthenticableGraphqlUser

    type Types::ProductType.connection_type, null: true

    def fetch_data
      current_user.company.products.order(price: :asc)
    end
  end
end
