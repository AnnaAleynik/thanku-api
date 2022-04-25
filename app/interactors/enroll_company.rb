class EnrollCompany
  include Interactor::Organizer
  include TransactionalInteractor

  delegate :user, :possession_token, :company, to: :context

  organize CreateCompany,
           CreateOwner,
           CreateAccessToken,
           CreateRefreshToken,
           CreatePossessionToken

  after do
    RegisterActivityJob.perform_later(user.id, :user_registered)
    ApplicationMailer.confirm_user(possession_token, user, company).deliver_later
  end
end
