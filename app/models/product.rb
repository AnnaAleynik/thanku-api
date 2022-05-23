class Product < ApplicationRecord
  include ImageUploader::Attachment(:picture)

  belongs_to :company

  validates :name, presence: true
  validates :price, :count, numericality: { greater_than_or_equal_to: 0 }
end
