module Orders
  class PrepareParams
    include Interactor

    delegate :order_params, :current_user, to: :context

    def call
      order_params.merge!(user: current_user)
      context.product = product
      context.order = order
    end

    private

    def product
      Product.find(order_params[:product_id])
    end

    def order
      Order.new(order_params)
    end
  end
end
