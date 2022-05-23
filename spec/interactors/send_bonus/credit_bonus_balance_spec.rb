require "rails_helper"

describe SendBonus::CreditBonusBalance do
  include_context "with interactor"

  let(:initial_context) do
    {
      amount: 10,
      receiver: receiver
    }
  end
  let(:receiver) { create :employee, bonus_balance: 100 }

  describe ".call" do
    it_behaves_like "success interactor"

    it "credits receiver's bonus balance" do
      interactor.run

      expect(receiver.reload.bonus_balance).to eq(110)
    end
  end
end
