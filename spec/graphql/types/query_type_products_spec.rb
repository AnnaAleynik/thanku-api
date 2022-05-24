require "rails_helper"

describe Types::QueryType do
  include_context "when time is frozen"

  before do
    create :product, name: "T-shirt", price: 1000, count: 7, company: company
    create :product, name: "Labirint Certificate", price: 500, count: 2, company: company
    create :product, name: "Sticker pack", price: 100, count: 10, company: company
    create :product, name: "Cap", price: 700, count: 8, company: company
  end

  let(:execution_context) { { context: { current_user: user } } }
  let(:schema_context) { { current_user: user } }
  let(:company) { create :company }
  let(:user) { create :user, :owner, company: company }

  let(:query) do
    <<-GRAPHQL
      query {
        products {
          edges {
            cursor
            node {
              name
              price
              count
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
    let(:fixture_path) { "json/acceptance/graphql/query_type_products.json" }
  end
end
