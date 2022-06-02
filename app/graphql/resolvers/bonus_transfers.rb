module Resolvers
  class BonusTransfers < Resolvers::Base
    argument :user_id, ID, required: false
    argument :kind, Types::BonusTransfersKindType, required: false

    type Types::BonusTransferType.connection_type, null: true

    def fetch_data
      if options.empty?
        current_company.bonus_transfers
      else
        list
      end
    end

    private

    def list
      user = current_company.users.find(options[:user_id])
      kind = options[:kind] || "sended"
      user.send("#{kind}_bonus_transfers")
    end
  end
end
