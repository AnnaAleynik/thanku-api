class SendBonus
  class CheckSolvency
    include Interactor

    delegate :amount, :current_user, to: :context

    def call
      context.fail!(error_data: error_data) if test
    end

    private

    def test
      current_user.bonus_allowance < amount
    end

    def error_data
      { message: "You don't have enough bonus", status: 402, code: :payment_required }
    end
  end
end
