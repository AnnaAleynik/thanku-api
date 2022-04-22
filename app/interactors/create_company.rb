class CreateCompany
  include Interactor

  delegate :company_params, to: :context

  def call
    context.company = Company.new(company_params)

    context.fail!(error_data: error_data) unless context.company.save
  end

  private

  def error_data
    { message: "Record Invalid", detail: context.company.errors.to_a }
  end
end
