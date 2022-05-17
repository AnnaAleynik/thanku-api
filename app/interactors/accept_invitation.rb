class AcceptInvitation
  include Interactor

  delegate :user_params, :user, to: :context

  def call
    context.user = invited_user

    context.fail!(error_data: invalid_token_data) if user.blank?
    context.fail!(error_data: error_data) unless accept_invitation_form.valid? && update_user
  end

  private

  def invited_user
    User.find_by(invitation_token: invitation_token)
  end

  def invitation_token
    @invitation_token ||= user_params.delete(:invitation_token)
  end

  def update_user
    user.update(user_update_params)
  end

  def user_update_params
    accept_invitation_form.model_attributes.merge(
      invitation_accepted_at: Time.current,
      invitation_token: nil
    )
  end

  def accept_invitation_form
    @accept_invitation_form ||= AcceptInvitationForm.new(user).assign_attributes(user_params)
  end

  def invalid_token_data
    { message: "Invalid token", status: 400, code: :bad_request }
  end

  def error_data
    {
      message: "Record Invalid",
      detail: accept_invitation_form.errors.to_a,
      status: 422,
      code: :unproccessable_entity
    }
  end
end
