module Resolvers
  class BonusTransfers < Resolvers::Base
    type Types::BonusTransferType.connection_type, null: true

    def fetch_data
      current_company.bonus_transfers
    end
  end
end
