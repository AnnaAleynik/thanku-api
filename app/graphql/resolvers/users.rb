module Resolvers
  class Users < Resolvers::Base
    include AuthenticableGraphqlUser

    type Types::UserType.connection_type, null: true

    def fetch_data
      current_user.colleagues.active.where.not(id: current_user.id).order(email: :asc)
    end
  end
end
