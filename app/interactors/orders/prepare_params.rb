module Orders
  class PrepareParams
    include Interactor

    delegate :order_params, :current_user, :current_company, to: :context

    def call
      order_params.merge!(user: current_user)
      context.product = product
      context.order = order
    end

    private

    def product
      current_company.products.find(order_params[:product_id])
    end

    def order
      Order.new(order_params)
    end
  end
end
