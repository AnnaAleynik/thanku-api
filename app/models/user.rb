class User < ApplicationRecord
  extend Enumerize
  include ImageUploader::Attachment(:avatar)

  ROLES = %w[account employee admin manager owner].freeze

  has_secure_password
  has_secure_token :password_reset_token

  belongs_to :company

  has_many :activities, dependent: :destroy
  has_many :refresh_tokens, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :bonus_allowance, :bonus_balance, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :login, length: { minimum: 3 }, if: :confirmed_at

  enumerize :role, in: ROLES, predicates: true, default: "account", scope: :shallow
end
