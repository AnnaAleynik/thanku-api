class SendBonus
  include Interactor::Organizer
  include TransactionalInteractor

  delegate :bonus_transfer, to: :context

  organize SendBonus::PrepareParams,
           SendBonus::CheckSolvency,
           SendBonus::DebitBonusAllowance,
           SendBonus::CreditBonusBalance,
           SendBonus::SaveBonusTransfer

  after do
    SendBonusReceivedEmailJob.perform_later(bonus_transfer.id)
  end
end
