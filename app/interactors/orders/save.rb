module Orders
  class Save
    include Interactor

    delegate :order, to: :context

    def call
      context.fail!(error_data: error_data) unless order.save
    end

    private

    def error_data
      { message: "Record Invalid", detail: context.product.errors.to_a, status: 422 }
    end
  end
end
