require "rails_helper"

describe SendBonus::DebitBonusAllowance do
  include_context "with interactor"

  let(:initial_context) do
    {
      amount: 10,
      current_user: current_user
    }
  end
  let(:current_user) { create :employee, bonus_allowance: 100 }

  describe ".call" do
    context "when amount is less than bonus allowance" do
      it_behaves_like "success interactor"

      it "debits sender bonus allowance" do
        interactor.run

        expect(current_user.bonus_allowance).to eq(90)
      end
    end
  end
end
