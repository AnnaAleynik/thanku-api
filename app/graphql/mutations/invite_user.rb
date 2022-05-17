module Mutations
  class InviteUser < BaseMutation
    include AuthenticableGraphqlUser

    argument :user_params, Types::InviteUserInput, required: true

    type Types::Payloads::InviteUserPayload

    def resolve(user_params:)
      authorize! current_user, to: :create?, with: InvitationPolicy

      invited_user = ::InviteUser.call(
        user_params: user_params.to_h,
        current_user: current_user
      )

      invited_user.success? ? invited_user : execution_error(error_data: invited_user.error_data)
    end
  end
end
