module Products
  class Create
    include Interactor

    delegate :product_params, :current_user, to: :context

    def call
      product_params.merge!(
        company: current_user.company
      )
      context.product = Product.new(product_params)
      context.fail!(error_data: error_data) unless context.product.save
    end

    private

    def error_data
      { message: "Record Invalid", detail: context.product.errors.to_a, status: 422 }
    end
  end
end
