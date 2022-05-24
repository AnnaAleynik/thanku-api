require "rails_helper"

describe Types::QueryType do
  include_context "when time is frozen"

  let(:execution_context) { { context: { current_user: user } } }
  let(:schema_context) { { current_user: user } }
  let(:company) { create :company }
  let(:user) { create :user, :owner, company: company }

  before do
    create :employee, company: company
    create :johann_sebastian_employee, company: company
    create :user, :invited_not_accepted, company: company
  end

  context "when first activity" do
    let(:query) do
      <<-GRAPHQL
        query {
          users(first: 1) {
            edges {
              cursor
              node {
                email
                firstName
                lastName
              }
            }
            pageInfo {
              endCursor
              startCursor
              hasPreviousPage
              hasNextPage
            }
          }
        }
      GRAPHQL
    end

    it_behaves_like "graphql request", "get first activity" do
      let(:fixture_path) { "json/acceptance/graphql/query_type_users/first_page.json" }
    end
  end

  context "with authorized user" do
    it_behaves_like "graphql request", "includes user private activities to result" do
      let(:fixture_path) { "json/acceptance/graphql/query_type_users/all.json" }

      let(:query) do
        <<-GRAPHQL
          query {
            users {
              edges {
                cursor
                node {
                  email
                  firstName
                  lastName
                }
              }
              pageInfo {
                endCursor
                startCursor
                hasPreviousPage
                hasNextPage
              }
            }
          }
        GRAPHQL
      end
    end
  end
end
