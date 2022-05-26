module Resolvers
  class Products < Resolvers::Base
    include AuthenticableGraphqlUser

    type Types::ProductType.connection_type, null: true

    def fetch_data
      # TODO
      current_user.company.products.order(price: :asc)
    end
  end
end
