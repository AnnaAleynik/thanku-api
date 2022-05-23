class BonusTransfer < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :parent, class_name: "BonusTransfer", optional: true

  has_many :bonus_transfers, class_name: "BonusTransfer", dependent: :destroy, foreign_key: "parent_id"

  validates :amount, numericality: { greater_than: 0 }
  validates :comment, presence: true

  validates_with BonusReceiverValidator
end
