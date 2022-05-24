module Mutations
  class DestroyProduct < BaseMutation
    include AuthenticableGraphqlUser

    argument :id, ID, required: true

    type Types::Payloads::ProductPayload

    def resolve(id:)
      authorize! current_user, to: :manage_product?, with: ::UserPolicy

      destroy_product = ::Products::Update.call(
        product_id: id,
        current_user: current_user
      )

      destroy_product.success? ? destroy_product : execution_error(error_data: destroy_product.error_data)
    end
  end
end
