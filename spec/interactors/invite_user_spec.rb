require "rails_helper"

describe InviteUser do
  describe "#call" do
    include_context "with interactor"

    let(:user_params) do
      {
        email: "invited@example.com",
        first_name: first_name,
        last_name: "Last",
        role: "manager"
      }
    end
    let(:current_user) { create :user, :owner, company: company }
    let(:company) { create :company }
    let(:initial_context) do
      {
        user_params: user_params,
        current_user: current_user
      }
    end
    let(:invited_user) { User.last }

    let(:expected_user_params) do
      {
        email: "invited@example.com",
        first_name: "First",
        last_name: "Last",
        role: "manager",
        invited_by: current_user,
        bonus_allowance: 500,
        bonus_balance: 0
      }
    end

    context "when params are valid" do
      let(:first_name) { "First" }

      it "creates user" do
        interactor.run

        expect(invited_user).to have_attributes(expected_user_params)
      end
    end

    context "when params are invalid" do
      let(:first_name) { "" }
      let(:error_data) do
        {
          detail: ["First name can't be blank"],
          message: "Record Invalid"
        }
      end

      it_behaves_like "failed interactor"
    end
  end

  describe "#after" do
    let(:company) { create :company }
    let(:user_id) { 223_445 }
    let(:user) { create :user, :employee, :invited_not_accepted, id: user_id, company: company }
    let(:initial_context) { { user: user, company: company } }
    let(:event) { :user_invited }

    context "when organizer succeeds" do
      include_context "with stubbed organizer"

      it_behaves_like "activity source"
      it "schedules invitation job" do
        interactor.run
        expect(InviteUserJob).to have_been_enqueued.with(user_id)
      end
    end

    context "when organizer failures" do
      include_context "with stubbed organizer", failure: true

      it "does not invite user" do
        interactor.run
        expect(RegisterActivityJob).not_to have_been_enqueued
        expect(InviteUserJob).not_to have_been_enqueued
      end
    end
  end
end
