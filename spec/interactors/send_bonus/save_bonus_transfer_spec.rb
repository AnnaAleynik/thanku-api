require "rails_helper"

describe SendBonus::SaveBonusTransfer do
  include_context "with interactor"

  let(:initial_context) do
    {
      bonus_transfer: bonus_transfer
    }
  end
  let(:current_user) { create :employee }
  let!(:receiver) { create :johann_sebastian_employee }
  let(:bonus_transfer) do
    build :bonus_transfer, amount: 10, comment: comment, sender: current_user,
                           receiver: receiver
  end

  describe ".call" do
    let(:comment) { "#win-win-win ThankU for help!" }

    it_behaves_like "success interactor"

    it "creates bonus transfer" do
      expect { interactor.run }.to change(BonusTransfer, :count).from(0).to(1)
    end
  end
end
