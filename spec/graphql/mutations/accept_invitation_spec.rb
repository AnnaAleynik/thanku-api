require "rails_helper"

describe Mutations::AcceptInvitation do
  include_context "when time is frozen"

  let(:user) { create :user, :invited_not_accepted }
  let(:invitation_token) { user.invitation_token }
  let(:password) { "12345678" }
  let(:confirm_password) { "12345678" }

  let(:query) do
    <<-GRAPHQL
      mutation {
        acceptInvitation (
          input: {
            invitationToken: "#{invitation_token}",
            login: "Login",
            password: "#{password}",
            confirmPassword: "#{confirm_password}",
            birthdate: "2006-05-30"
          }
        ) {
          me {
            id
            email
            login
            birthdate
          }
        }
      }
    GRAPHQL
  end

  context "with valid data" do
    it_behaves_like "graphql request", "returns updated user info" do
      let(:fixture_path) { "json/acceptance/graphql/accept_invitation/success.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:id/,
          ":id" => user.id
        )
      end
    end
  end

  context "with invalid invitation token" do
    let(:invitation_token) { "invitation_token1" }

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/accept_invitation/wrong_invitation_token.json" }
    end
  end

  context "with invalid password" do
    let(:confirm_password) { "password" }

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/accept_invitation/with_invalid_password.json" }
    end
  end
end
