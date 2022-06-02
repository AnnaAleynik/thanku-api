require "rails_helper"

describe InviteUser::BuildUser do
  include_context "with interactor"

  let(:initial_context) do
    {
      user_params: user_params,
      current_user: current_user
    }
  end
  let(:company) { create :company, bonus_amount: 100 }
  let(:current_user) { create :user, :manager, company: company }
  let(:expected_password) { "12345678" }
  let(:expected_invitation_token) { "abcd1234" }

  before do
    allow(SecureRandom).to receive(:hex).with(140).and_return(expected_invitation_token)
    allow(SecureRandom).to receive(:hex).with(16).and_return(expected_password)
  end

  describe ".call" do
    context "with valid data" do
      let(:user_params) do
        {
          email: "user@example.com",
          first_name: "Doctor",
          last_name: "Who",
          role: "employee"
        }
      end

      it_behaves_like "success interactor"

      it "creates user" do
        interactor.run

        expect(context.user).to have_attributes(
          {
            email: "user@example.com",
            first_name: "Doctor",
            last_name: "Who",
            role: "employee",
            company: company,
            invited_by: current_user,
            invitation_token: expected_invitation_token,
            password: expected_password,
            bonus_allowance: 100,
            bonus_balance: 0
          }
        )
      end
    end
  end
end
