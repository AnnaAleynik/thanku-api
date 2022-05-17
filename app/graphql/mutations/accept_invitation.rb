module Mutations
  class AcceptInvitation < BaseMutation
    argument :input, Types::AcceptInvitationInput, required: true

    type Types::Payloads::AcceptInvitationPayload

    def resolve(input:)
      result = ::AcceptInvitation.call(user_params: input.to_h)

      result.success? ? result : execution_error(error_data: result.error_data)
    end
  end
end
