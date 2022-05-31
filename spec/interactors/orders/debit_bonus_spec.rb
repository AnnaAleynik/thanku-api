require "rails_helper"

describe Orders::DebitBonus do
  include_context "with interactor"

  let(:initial_context) do
    {
      order: order,
      current_user: current_user
    }
  end
  let(:current_user) { create :employee, bonus_balance: 100 }
  let(:order) { build :order, price: price, quantity: 1 }

  describe ".call" do
    context "when order value is less than bonus balance" do
      let(:price) { 10 }

      it_behaves_like "success interactor"

      it "debits bonus" do
        interactor.run

        expect(current_user.bonus_balance).to eq(90)
      end
    end

    context "when order value is greater than bonus balance" do
      let(:price) { 200 }
      let(:error_data) do
        {
          code: :payment_required,
          message: "You don't have enough bonus",
          status: 402
        }
      end

      it_behaves_like "failed interactor"

      it "does not debit bonus" do
        expect(current_user.bonus_balance).to eq(100)
      end
    end
  end
end
