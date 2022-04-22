module Mutations
  class SignUp < BaseMutation
    argument :user, Types::SignUpInput, required: true
    argument :company, Types::CompanyInput, required: true

    type Types::Payloads::SignUpPayload

    def resolve(user:, company:)
      signup_user = EnrollCompany.call(user_params: user.to_h, company_params: company.to_h)

      signup_user.success? ? signup_user : execution_error(error_data: signup_user.error_data)
    end
  end
end
