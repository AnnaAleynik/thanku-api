require "rails_helper"

describe Mutations::InviteUser do
  include_context "when time is frozen"
  include_context "with mail delivery stubbed"

  let(:execution_context) { { context: { current_user: current_user } } }
  let(:schema_context) { { current_user: current_user } }
  let(:invited_user) { User.last }
  let(:email) { "bilbo.baggins@shire.com" }
  let(:current_user) { create :user, :owner }

  let(:query) do
    <<-GRAPHQL
      mutation {
        inviteUser(
          userParams: {
            email: "#{email}",
            firstName: "Wolfgang Amadeus",
            lastName: "Mozart",
            role: MANAGER
          }
        ) {
          invitedUser {
            id
            email
            firstName
            lastName
          }
        }
      }
    GRAPHQL
  end

  context "with valid data" do
    it_behaves_like "graphql request", "invite a new user" do
      let(:fixture_path) { "json/acceptance/graphql/invite_user/invite_user.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:id/,
          ":id" => invited_user.id
        )
      end
    end
  end

  context "with invalid data" do
    let(:email) { "bilbo.baggins" }

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/invite_user/wrong.json" }
    end
  end

  context "when user not authorized to perform this action" do
    let(:current_user) { create :user, role: "employee" }

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/invite_user/unauthorized.json" }
    end
  end
end
