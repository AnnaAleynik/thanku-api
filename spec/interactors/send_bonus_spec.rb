require "rails_helper"

describe SendBonus do
  describe "#call" do
    include_context "with interactor"

    let(:initial_context) do
      {
        bonus_transfer_params: {
          amount: amount,
          comment: comment,
          parent_id: parent_id,
          receiver_id: receiver_id
        },
        current_user: current_user
      }
    end

    let(:current_user) { create :employee, bonus_allowance: 100 }
    let!(:receiver) { create :johann_sebastian_employee, id: 560_560, bonus_balance: 100 }
    let(:comment) { "#win-win-win ThankU for help!" }
    let(:amount) { 10 }
    let(:receiver_id) { 560_560 }
    let(:parent_id) { nil }

    let(:expected_bonus_transfer_attributes) do
      {
        sender: current_user,
        receiver: receiver,
        parent_id: parent_id,
        amount: amount,
        comment: comment
      }
    end

    it_behaves_like "success interactor"

    it "creates bonus transfer" do
      interactor.run

      expect(context.bonus_transfer).to have_attributes(expected_bonus_transfer_attributes)
      expect(receiver.reload.bonus_balance).to eq(110)
      expect(current_user.reload.bonus_allowance).to eq(90)
    end

    context "when it is comment to another bonus transfer" do
      let!(:parent_bt) { create :bonus_transfer, sender: current_user, receiver: receiver }
      let(:parent_id) { parent_bt.id }

      it_behaves_like "success interactor"

      it "creates bonus transfer" do
        expect { interactor.run }.to change(BonusTransfer, :count).from(1).to(2)

        expect(context.bonus_transfer).to have_attributes(expected_bonus_transfer_attributes)
      end
    end

    context "when comment is empty" do
      let(:comment) { "" }
      let(:error_data) do
        {
          code: :bad_request,
          status: 422,
          detail: ["Comment can't be blank"],
          message: "Record Invalid"
        }
      end

      it_behaves_like "failed interactor"

      it "does not transfer bonus" do
        expect { interactor.run }.not_to change(BonusTransfer, :count)
        expect(receiver.reload.bonus_balance).to eq(100)
        expect(current_user.reload.bonus_allowance).to eq(100)
      end
    end
  end

  describe "#after" do
    let(:current_user) { create :employee }
    let!(:receiver) { create :johann_sebastian_employee, bonus_balance: 110 }
    let(:bonus_transfer) do
      create :bonus_transfer, sender: current_user, receiver: receiver
    end

    let(:initial_context) do
      {
        bonus_transfer: bonus_transfer
      }
    end

    context "when organizer succeeds" do
      include_context "with stubbed organizer"

      it "send notifications" do
        interactor.run
        expect(SendBonusReceivedEmailJob).to have_been_enqueued.with(bonus_transfer.id)
      end
    end

    context "when organizer failures" do
      include_context "with stubbed organizer", failure: true

      it "does not invite user" do
        interactor.run
        expect(SendBonusReceivedEmailJob).not_to have_been_enqueued
      end
    end
  end
end
