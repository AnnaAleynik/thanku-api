class InviteUserJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    user.update!(
      invitation_sent_at: Time.current
    )
    ApplicationMailer.invite_user(user).deliver_now
  end
end
