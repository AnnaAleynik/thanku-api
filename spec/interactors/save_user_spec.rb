require "rails_helper"

describe SaveUser do
  describe ".call" do
    include_context "with interactor"

    let(:user) do
      build :johann_sebastian_employee, :invited_not_accepted,
            invited_by: current_user, first_name: first_name, company: company
    end
    let(:initial_context) { { user: user } }
    let(:current_user) { create :user, :owner, company: company }
    let(:company) { create :company }
    let(:first_name) { "Queen" }

    context "with valid data" do
      it_behaves_like "success interactor"

      it "creates user" do
        interactor.run

        expect(context.user).to be_persisted
        expect(context.user).to have_attributes(
          email: "invited@example.com",
          first_name: "Queen",
          last_name: "Bach",
          role: "employee",
          company_id: company.id,
          invited_by_id: current_user.id,
          bonus_allowance: 500,
          bonus_balance: 0
        )
      end
    end

    context "with invalid data" do
      let(:first_name) { "" }

      let(:error_data) do
        { message: "Record Invalid", detail: ["First name can't be blank"] }
      end

      it_behaves_like "failed interactor"
    end
  end
end
