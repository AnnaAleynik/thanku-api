class CreateOwner
  include Interactor

  delegate :user_params, :company, to: :context

  def call
    user_params.merge!(role: "owner", company: company)

    context.user = User.new(user_params)

    context.fail!(error_data: error_data) unless context.user.save
  end

  private

  def error_data
    { message: "Record Invalid", detail: context.user.errors.to_a }
  end
end
