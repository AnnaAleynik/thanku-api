module Mutations
  class UpdateProduct < BaseMutation
    include AuthenticableGraphqlUser

    argument :id, ID, required: true
    argument :count, Int, required: false
    argument :price, Int, required: false
    argument :name, String, required: false
    argument :description, String, required: false
    argument :picture, Types::ImageUploaderType, required: false

    type Types::Payloads::ProductPayload

    def resolve(**params)
      authorize! current_user, to: :manage_product?, with: ::UserPolicy

      update_product = ::Products::Update.call(
        product_params: params,
        current_user: current_user
      )

      update_product.success? ? update_product : execution_error(error_data: update_product.error_data)
    end
  end
end
