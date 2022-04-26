class CreateInvitationToken
  include Interactor

  delegate :user, :current_user, to: :context

  def call
    user.update!(
      invitation_token: generate_value
    )
  end

  private

  def generate_value
    generated_value = SecureRandom.hex(token_length)
    return generated_value unless User.find_by(invitation_token: generated_value)

    generate_value
  end

  def token_length
    ENV.fetch("CONFIRMATION_TOKEN_LENGTH", 140).to_i
  end
end
