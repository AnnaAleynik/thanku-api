require "rails_helper"

describe Mutations::CreateProduct do
  let(:execution_context) { { context: { current_user: current_user } } }
  let(:schema_context) { { current_user: current_user } }
  let(:product) { Product.last }
  let(:current_user) { create :user, role: "manager" }
  let(:count) { 10 }

  let(:query) do
    <<-GRAPHQL
      mutation {
        createProduct(
          name: "T-shirt",
          count: #{count},
          price: 100
        ) {
          product {
            id
            name
            description
            count
            price
          }
        }
      }
    GRAPHQL
  end

  context "with valid data" do
    it_behaves_like "graphql request", "invite a new user" do
      let(:fixture_path) { "json/acceptance/graphql/create_product/with_valid_data.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:id/,
          ":id" => product.id
        )
      end
    end
  end

  context "with invalid data" do
    let(:count) { -1 }

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/create_product/with_invalid_data.json" }
    end
  end

  context "when user not authorized to perform this action" do
    let(:current_user) { create :user, role: "employee" }

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/create_product/unauthorized.json" }
    end
  end
end
