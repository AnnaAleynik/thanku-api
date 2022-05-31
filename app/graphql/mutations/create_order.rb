module Mutations
  class CreateOrder < BaseMutation
    include AuthenticableGraphqlUser

    argument :product_id, ID, required: true
    argument :quantity, Int, required: true
    argument :price, Int, required: true
    argument :comment, String, required: false

    type Types::Payloads::OrderPayload

    def resolve(**params)
      create_order = ::Orders::Create.call(
        order_params: params,
        current_user: current_user,
        current_company: current_company
      )

      create_order.success? ? create_order : execution_error(error_data: create_order.error_data)
    end
  end
end
