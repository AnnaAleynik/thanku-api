module Mutations
  class UpdateCompany < BaseMutation
    argument :input, Types::UpdateCompanyInput, required: true

    type Types::Payloads::UpdateCompanyPayload

    def resolve(input:)
      authorize! current_company, to: :update?, with: CompanyPolicy

      update_user = ::UpdateCompany.call(
        user: context[:current_user], company_params: input.to_h
      )

      update_user.success? ? update_user : execution_error(error_data: update_user.error_data)
    end
  end
end
