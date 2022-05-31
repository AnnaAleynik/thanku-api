class SendBonus
  class PrepareParams
    include Interactor

    delegate :bonus_transfer_params, :current_user, :current_company, to: :context

    def call
      context.amount = bonus_transfer_params[:amount]
      find_receiver
      build_bonus_transfer
      context.fail!(error_data: error_data) unless context.bonus_transfer.valid?
    end

    private

    def find_parent
      return unless bonus_transfer_params[:parent_id]

      # current_company
      @find_parent ||= BonusTransfer.find(bonus_transfer_params[:parent_id])
    end

    def find_receiver
      context.receiver = find_parent&.receiver || current_company.users.find(bonus_transfer_params[:receiver_id])
    end

    def build_bonus_transfer
      context.bonus_transfer = BonusTransfer.new(
        receiver: context.receiver,
        sender: current_user,
        comment: bonus_transfer_params[:comment],
        amount: context.amount,
        parent: find_parent
      )
    end

    def error_data
      { message: "Record Invalid", detail: context.bonus_transfer.errors.to_a, status: 422, code: :bad_request }
    end
  end
end
