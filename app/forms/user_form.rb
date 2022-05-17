class UserForm < ApplicationForm
  USER_ATTRIBUTES = %i[email first_name last_name password avatar login birthdate].freeze
  ATTRIBUTES = USER_ATTRIBUTES

  attr_accessor(*ATTRIBUTES)

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def attribute_names
    @attribute_names ||= ATTRIBUTES
  end

  def model_attribute_names
    @model_attribute_names ||= USER_ATTRIBUTES
  end
end
