module Mutations
  class CreateProduct < BaseMutation
    include AuthenticableGraphqlUser

    argument :count, Int, required: true
    argument :price, Int, required: true
    argument :name, String, required: true
    argument :description, String, required: false
    argument :picture, Types::ImageUploaderType, required: false

    type Types::Payloads::ProductPayload

    def resolve(**params)
      authorize! current_user, to: :manage_product?, with: ::UserPolicy

      create_product = ::Products::Create.call(
        product_params: params,
        current_user: current_user
      )

      create_product.success? ? create_product : execution_error(error_data: create_product.error_data)
    end
  end
end
