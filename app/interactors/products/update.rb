module Products
  class Update
    include Interactor

    delegate :product_params, to: :context

    def call
      context.product = product
      context.fail!(error_data: error_data) unless context.product.update(product_params)
    end

    private

    def product
      @product ||= Product.find(product_id)
    end

    def product_id
      @product_id ||= product_params.delete(:id)
    end

    def error_data
      { message: "Record Invalid", detail: context.product.errors.to_a, status: 422 }
    end
  end
end
