require "rails_helper"

describe Mutations::CreateOrder do
  let(:execution_context) { { context: { current_user: current_user } } }
  let(:schema_context) { { current_user: current_user } }
  let(:product) { create :product, count: 1 }
  let(:current_user) { create :user, bonus_balance: 100 }
  let(:price) { 100 }
  let(:quantity) { 1 }
  let(:order) { Order.last }

  let(:query) do
    <<-GRAPHQL
      mutation {
        createOrder(
          productId: #{product.id},
          quantity: #{quantity},
          price: #{price}
        ) {
          order {
            id
            quantity
            price
          }
          me {
            bonusBalance
          }
        }
      }
    GRAPHQL
  end

  context "with valid data" do
    it_behaves_like "graphql request", "invite a new user" do
      let(:fixture_path) { "json/acceptance/graphql/create_order/with_valid_data.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:id/,
          ":id" => order.id
        )
      end
    end
  end

  context "when bonus balance is less than order value" do
    let(:price) { 1000 }

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/create_order/when_bonus_not_enough.json" }
    end
  end

  context "when quantity is less than product count" do
    let(:quantity) { 1000 }

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/create_order/when_quantity_not_enough.json" }
    end
  end
end
