class BonusReceiverValidator < ActiveModel::Validator
  def validate(record)
    return unless record.receiver_id == record.sender_id

    record.errors.add :receiver_id, "can't get a bonus from yourself"
  end
end
