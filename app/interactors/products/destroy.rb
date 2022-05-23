module Products
  class Destroy
    include Interactor

    delegate :product_id, to: :context

    def call
      context.product = product.destroy
    end

    private

    def product
      @product ||= Product.find(product_id)
    end

    def error_data
      { message: "Record Invalid", detail: context.product.errors.to_a, status: 422 }
    end
  end
end
