class User < ApplicationRecord
  extend Enumerize
  include ImageUploader::Attachment(:avatar)

  ROLES = %w[account employee admin manager owner].freeze

  has_secure_password
  has_secure_token :password_reset_token

  has_many :activities, dependent: :destroy
  has_many :refresh_tokens, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  enumerize :role, in: ROLES, predicates: true, default: "account"

  def login
    login || "#{user.first_name}.#{user.last_name}"
  end
end
