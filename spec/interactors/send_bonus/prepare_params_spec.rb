require "rails_helper"

describe SendBonus::PrepareParams do
  include_context "with interactor"

  let(:initial_context) do
    {
      bonus_transfer_params: {
        amount: 10,
        receiver_id: receiver_id,
        parent_id: nil,
        comment: "#win-win-win ThankU for help!"
      },
      current_user: current_user,
      current_company: current_user.company
    }
  end
  let(:current_user) { create :employee }

  describe ".call" do
    context "when data is valid" do
      let(:receiver_id) { 560_560 }
      let!(:receiver) { create :johann_sebastian_employee, id: 560_560, company: current_user.company }

      let(:expected_bonus_transfer_attributes) do
        {
          sender: current_user,
          receiver: receiver,
          amount: 10,
          comment: "#win-win-win ThankU for help!"
        }
      end

      it_behaves_like "success interactor"

      it "creates bonus transfer" do
        interactor.run

        expect(context.bonus_transfer).to have_attributes(expected_bonus_transfer_attributes)
      end
    end

    context "when data is invalid" do
      let(:receiver_id) { current_user.id }

      let(:error_data) do
        {
          message: "Record Invalid",
          detail: ["Receiver can't get a bonus from yourself"],
          status: 422,
          code: :bad_request
        }
      end

      it_behaves_like "failed interactor"

      it "does not create bonus transfer" do
        interactor.run

        expect { interactor.run }.not_to change(BonusTransfer, :count)
      end
    end
  end
end
