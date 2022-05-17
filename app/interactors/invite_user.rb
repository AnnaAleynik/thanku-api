class InviteUser
  include Interactor::Organizer
  include TransactionalInteractor

  delegate :user, to: :context

  organize InviteUser::BuildUser,
           SaveUser

  after do
    InviteUserJob.perform_later(user.id)
    RegisterActivityJob.perform_later(user.id, :user_invited)
  end
end
