class Company < ApplicationRecord
  has_many :managers, -> { manager }, dependent: :destroy, class_name: "User", inverse_of: :company
  has_many :users, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :bonus_transfers, through: :users, source: :sended_bonus_transfers

  has_one :owner, -> { owner }, class_name: "User", inverse_of: :company, dependent: :destroy

  validates :name, presence: true
  validates :bonus_amount, numericality: { greater_than: 0 }
end
