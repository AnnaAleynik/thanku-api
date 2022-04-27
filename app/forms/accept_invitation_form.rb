class AcceptInvitationForm < UserForm
  ATTRIBUTES = (USER_ATTRIBUTES + %i[confirm_password]).freeze

  attr_accessor(*ATTRIBUTES)

  validate :check_confirm_password, :check_login_uniqueness
  validates :confirm_password, presence: true
  validates :password, length: { maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED }
  validates :login, length: { minimum: 3 }

  def attribute_names
    @attribute_names ||= ATTRIBUTES
  end

  def model_attribute_names
    @model_attribute_names ||= USER_ATTRIBUTES
  end

  private

  def check_confirm_password
    return if password == confirm_password

    errors.add(:confirm_password, "should be the same as new password")
  end

  def check_login_uniqueness
    return unless User.find_by(login: login)

    errors.add(:login, "has already been taken")
  end
end
