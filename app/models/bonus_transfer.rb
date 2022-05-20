class BonusTransfer < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  has_many :bonus_transfers, dependent: :destroy

  validates :amount, numericality: { greater_than: 0 }
  validates :comment, presence: true

  validates_with BonusReceiverValidator
end
