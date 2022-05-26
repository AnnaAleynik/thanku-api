class Order < ApplicationRecord
  extend Enumerize

  STATUSES = %w[created pending accepted canceled].freeze

  belongs_to :product
  belongs_to :user
  belongs_to :manager, class_name: "User", optional: true

  has_one :company, through: :user

  validates :price, presence: true
  enumerize :status, in: STATUSES, default: "created", predicates: true, scope: :shallow
end
