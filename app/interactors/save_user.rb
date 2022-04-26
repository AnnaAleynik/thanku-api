class SaveUser
  include Interactor

  delegate :user, to: :context

  def call
    context.fail!(error_data: error_data) unless user.save
  end

  private

  def error_data
    { message: "Record Invalid", detail: user.errors.to_a }
  end
end
