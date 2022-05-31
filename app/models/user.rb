class User < ApplicationRecord
  extend Enumerize
  include ImageUploader::Attachment(:avatar)

  ROLES = %w[account employee admin manager owner].freeze

  has_secure_password
  has_secure_token :password_reset_token

  belongs_to :company

  belongs_to :invited_by, class_name: "User", optional: true

  has_many :activities, dependent: :destroy
  has_many :refresh_tokens, dependent: :destroy
  has_many :sended_bonus_transfers, foreign_key: "sender_id"
  has_many :received_bonus_transfers, foreign_key: "receiver_id"

  has_many :orders, dependent: :destroy
  has_many :proccesed_orders, class_name: "Order", foreign_key: "manager_id",
                              dependent: :destroy, inverse_of: "manager"
  has_many :colleagues, through: :company, source: :users, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :bonus_allowance, :bonus_balance, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :login, length: { minimum: 3 }, unless: :invitation_token
  validates :first_name, :last_name, presence: true
  validates :login, :invitation_token, uniqueness: true, allow_nil: true

  enumerize :role, in: ROLES, predicates: true, default: "account", scope: :shallow

  scope :active, -> { where(invitation_token: nil) }
end
