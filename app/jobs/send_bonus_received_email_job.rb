class SendBonusReceivedEmailJob < ApplicationJob
  queue_as :default

  def perform(bonus_transfer_id)
    bonus_transfer = BonusTransfer.find(bonus_transfer_id)
    ApplicationMailer.bonus_received(bonus_transfer).deliver_now
  end
end
