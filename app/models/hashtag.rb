class Hashtag < ApplicationRecord
  belongs_to :company

  validates :name, presence: true, uniqueness: { scope: :company }
end
