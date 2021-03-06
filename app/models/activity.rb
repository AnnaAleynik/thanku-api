class Activity < ApplicationRecord
  extend Enumerize

  belongs_to :user

  enumerize :event, in: %i[user_registered user_logged_in user_updated reset_password_requested
                           user_reset_password user_invited]

  scope :public_events, -> { where(event: %i[user_registered user_logged_in]) }

  validates :title, :body, presence: true
end
