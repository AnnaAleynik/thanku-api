class SendBonus
  class CreditBonusBalance
    include Interactor

    delegate :amount, :receiver, to: :context

    def call
      credit
      context.fail!(error_data: error_data) unless receiver.save
    end

    private

    def credit
      receiver.bonus_balance = receiver.bonus_balance + amount
    end

    def error_data
      { message: "Something went wrong", status: 422, code: :bad_request }
    end
  end
end
