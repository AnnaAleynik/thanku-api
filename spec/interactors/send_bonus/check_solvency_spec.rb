require "rails_helper"

describe SendBonus::CheckSolvency do
  include_context "with interactor"

  let(:initial_context) do
    {
      amount: amount,
      current_user: current_user
    }
  end
  let(:current_user) { create :employee, bonus_allowance: 100 }

  describe ".call" do
    context "when amount is less than bonus allowance" do
      let(:amount) { 10 }

      it_behaves_like "success interactor"
    end

    context "when amount is greater than bonus allowance" do
      let(:amount) { 200 }
      let(:error_data) do
        {
          code: :payment_required,
          message: "You don't have enough bonus",
          status: 402
        }
      end

      it_behaves_like "failed interactor"
    end
  end
end
