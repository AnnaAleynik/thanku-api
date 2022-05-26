module Orders
  class ChangeProductQuantity
    include Interactor

    delegate :order, :product, to: :context

    def call
      context.fail!(error_data: error_data) unless product.update(count: product_count)
    end

    private

    def product_count
      product.count - order.quantity
    end

    def error_data
      { message: "We don't have enough products. Try later.", status: 422 }
    end
  end
end
