module Mutations
  class SendBonus < BaseMutation
    include AuthenticableGraphqlUser

    argument :amount, Int, required: true
    argument :comment, String, required: true
    argument :receiver_id, ID, required: false
    argument :parent_id, ID, required: false

    type Types::Payloads::SendBonusPayload

    def resolve(**params)
      send_bonus = ::SendBonus.call(
        bonus_transfer_params: params,
        current_user: current_user,
        current_company: current_company
      )

      send_bonus.success? ? send_bonus : execution_error(error_data: send_bonus.error_data)
    end
  end
end
