module Resolvers
  class Users < Resolvers::Base
    type Types::BonusTransferType.connection_type, null: true

    def fetch_data
      current_user.company.users.includes(:bonus_transfer)
    end
  end
end
