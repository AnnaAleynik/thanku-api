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

  def invite_user
    user = FactoryBot.create(:user, :invited_not_accepted)

    ApplicationMailer.invite_user(user)
  end

  def bonus_received
    bonus_transfer = FactoryBot.create(:bonus_transfer)

    ApplicationMailer.bonus_received(bonus_transfer)
  end

  def order_created
    order = FactoryBot.create(:order)
    emails = ["test@test.com", "test1@test.test"]

    ApplicationMailer.order_created(order, emails)
  end
end
