require "rails_helper"

describe Types::QueryType do
  include_context "when time is frozen"

  before do
    create :bonus_transfer, receiver: user2, sender: user3, amount: 1, comment: "thx"
    create :bonus_transfer, receiver: user, sender: user3, amount: 10, comment: "cool"
    create :bonus_transfer, receiver: user2, sender: user, amount: 3, comment: "win"
    create :bonus_transfer, receiver: user5, sender: user4
  end

  let(:execution_context) { { context: { current_user: user, current_company: company } } }
  let(:schema_context) { { current_user: user, current_company: company } }
  let(:company) { create :company }
  let(:another_company) { create :company }
  let(:user) { create :user, company: company, email: "first@email.com" }
  let(:user2) { create :user, company: company, email: "second@email.com" }
  let(:user3) { create :user, company: company, email: "third@email.com" }
  let(:user4) { create :user, company: another_company, email: "another1@email.com" }
  let(:user5) { create :user, company: another_company, email: "another2@email.com" }

  let(:query) do
    <<-GRAPHQL
      query {
        bonusTransfers {
          edges {
            cursor
            node {
              sender {
                email
              }
              receiver {
                email
              }
              comment
              amount
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
    let(:fixture_path) { "json/acceptance/graphql/query_type_bonus_transfers.json" }
  end
end
