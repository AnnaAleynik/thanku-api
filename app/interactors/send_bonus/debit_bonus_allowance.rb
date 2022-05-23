class SendBonus
  class DebitBonusAllowance
    include Interactor

    delegate :amount, :current_user, to: :context

    def call
      debit
      context.fail!(error_data: error_data) unless current_user.save
    end

    private

    def debit
      current_user.bonus_allowance = current_user.bonus_allowance - amount
    end

    def error_data
      { message: "You don't have enough bonus", status: 422, code: :bad_request }
    end
  end
end
