require "rails_helper"

describe AcceptInvitation do
  describe ".call" do
    include_context "with interactor"
    include_context "when time is frozen"

    let(:user) { create :user, :invited_not_accepted }
    let(:initial_context) { { user_params: user_params } }
    let(:user_params) do
      {
        invitation_token: invitation_token,
        first_name: "Kate",
        login: "login",
        password: "password",
        confirm_password: "password"
      }
    end
    let(:invitation_accepted_at) { Time.current }
    let(:invitation_token) { user.invitation_token }

    context "with valid data" do
      it_behaves_like "success interactor"

      it "updates user" do
        interactor.run

        expect(context.user).to have_attributes(
          invitation_accepted_at: invitation_accepted_at,
          invitation_token: nil,
          login: "login",
          first_name: "Kate"
        )
      end
    end

    context "when invitation token is invalid" do
      let(:invitation_token) { "12345678" }

      let(:error_data) do
        {
          code: :bad_request,
          message: "Invalid token",
          status: 400
        }
      end

      it_behaves_like "failed interactor"
    end

    context "when login is not unique" do
      before do
        create :user, login: "login"
      end

      let(:error_data) do
        {
          code: :unproccessable_entity,
          detail: ["Login has already been taken"],
          message: "Record Invalid",
          status: 422
        }
      end

      it_behaves_like "failed interactor"
    end
  end
end
