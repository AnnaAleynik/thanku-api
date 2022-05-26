module Orders
  class DebitBonus
    include Interactor

    delegate :order, :current_user, to: :context

    def call
      context.fail!(error_data: error_data) unless current_user.update(bonus_balance: new_bonus_balance)
    end

    private

    def new_bonus_balance
      current_user.bonus_balance - (order.price * order.quantity)
    end

    def error_data
      { message: "You don't have enough bonus", status: 402, code: :payment_required }
    end
  end
end
