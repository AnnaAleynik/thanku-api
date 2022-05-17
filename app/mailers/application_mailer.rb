class ApplicationMailer < ActionMailer::Base
  layout "mailer"

  def password_recovery(user)
    @user = user
    @password_recovery_link = format(
      ENV.fetch("PASSWORD_RECOVERY_LINK_TEMPLATE"),
      password_reset_token: user.password_reset_token
    )

    mail(to: user.email)
  end

  def confirm_user(possession_token, user, company)
    @user = user
    @company = company
    @confirmation_link = format(
      ENV.fetch("CONFIRM_USER_LINK_TEMPLATE"),
      token_value: possession_token.value
    )

    mail(to: @user.email)
  end

  def invite_user(user)
    @user = user
    @company_name = user.company.name
    @accept_link = format(
      ENV.fetch("ACCEPT_INVITATION_LINK_TENPLATE"),
      token_value: user.invitation_token
    )

    mail(to: user)
  end
end
