require "rails_helper"

describe Mutations::SendBonus do
  include_context "when time is frozen"
  include_context "with mail delivery stubbed"

  before do
    create :johann_sebastian_employee, id: 123_123
  end

  let(:execution_context) { { context: { current_user: current_user } } }
  let(:schema_context) { { current_user: current_user } }
  let(:parent_id) { nil }
  let(:receiver_id) { 123_123 }
  let(:current_user) { create :employee, bonus_allowance: 100 }
  let(:bonus_transfer) { BonusTransfer.last }

  let(:query) do
    <<-GRAPHQL
      mutation {
        sendBonus(
          amount: 10,
          receiverId: "#{receiver_id}",
          comment: "#win-win-win ThankU for help!"
        ) {
          bonusTransfer {
            id
            sender {
              id
              firstName
            }
            receiver {
              id
              firstName
            }
            amount
            comment
            parentId
          }
        }
      }
    GRAPHQL
  end

  context "with valid data" do
    it_behaves_like "graphql request", "invite a new user" do
      let(:fixture_path) { "json/acceptance/graphql/send_bonus/with_valid_data.json" }

      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:id|:sender_id/,
          ":id" => bonus_transfer.id,
          ":sender_id" => current_user.id
        )
      end
    end
  end

  context "with invalid data" do
    let(:receiver_id) { current_user.id }

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/send_bonus/with_invalid_receiver_data.json" }
    end
  end
end
