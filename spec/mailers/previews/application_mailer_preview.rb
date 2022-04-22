class ApplicationMailerPreview < ActionMailer::Preview
  def password_recovery
    ApplicationMailer.password_recovery(
      FactoryBot.build(:user, password_reset_token: "1234")
    )
  end

  def confirm_user
    possession_token = FactoryBot.create(:possession_token, value: SecureRandom.base64(64))
    ApplicationMailer.confirm_user(
      possession_token,
      possession_token.user,
      possession_token.user.company
    )
  end
end
