class SendBonus
  class SaveBonusTransfer
    include Interactor

    delegate :bonus_transfer, to: :context

    def call
      context.fail!(error_data: error_data) unless bonus_transfer.save
    end

    private

    def error_data
      { message: "Record Invalid", detail: context.bonus_transfer.errors.to_a, status: 422, code: :bad_request }
    end
  end
end
