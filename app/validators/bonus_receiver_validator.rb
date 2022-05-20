class BonusReceiverValidator < ActiveModel::Validator
  def validate(record)
    return unless record.receiver_id == record.sender_id

    record.errors.add :receiver_id, "You can't send a bonus to yourself"
  end
end
