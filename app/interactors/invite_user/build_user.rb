class InviteUser
  class BuildUser
    include Interactor

    delegate :user_params, :current_user, to: :context
    delegate :company, to: :current_user
    delegate :bonus_amount, to: :company

    def call
      user_params.merge!(
        company: company,
        invited_by: current_user,
        password: SecureRandom.hex(16),
        invitation_token: generate_invitation_token,
        bonus_allowance: bonus_amount
      )
      context.user = User.new(user_params)
    end

    private

    def generate_invitation_token
      generated_value = SecureRandom.hex(token_length)
      return generated_value unless User.find_by(invitation_token: generated_value)

      generate_invitation_token
    end

    def token_length
      ENV.fetch("INVITATION_TOKEN_LENGTH", 140).to_i
    end
  end
end
