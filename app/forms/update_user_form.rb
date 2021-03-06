class UpdateUserForm < UserForm
  ATTRIBUTES = (USER_ATTRIBUTES + %i[current_password]).freeze

  attr_accessor(*ATTRIBUTES)

  validates :current_password, existing_password: true, presence: true, unless: -> { password.blank? }
  validates :password, length: { maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED },
                       allow_nil: true, allow_blank: true
  validates :login, length: { minimum: 3 }, allow_nil: true

  def attribute_names
    @attribute_names ||= ATTRIBUTES
  end

  def model_attribute_names
    @model_attribute_names ||= USER_ATTRIBUTES
  end
end
