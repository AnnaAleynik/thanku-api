require "rails_helper"

describe Orders::Create do
  describe "#call" do
    include_context "with interactor"

    let(:initial_context) do
      {
        current_user: current_user,
        order_params: {
          product_id: product.id,
          quantity: 1,
          price: price,
          comment: "Yellow"
        }
      }
    end
    let(:current_user) { create :user, bonus_balance: 100 }
    let(:product) { create :product }
    let(:price) { 20 }

    let(:expected_order_attributes) do
      {
        status: "created",
        product: product,
        quantity: 1,
        price: 20,
        comment: "Yellow"
      }
    end

    it_behaves_like "success interactor"

    it "creates order" do
      interactor.run

      expect(context.order).to have_attributes(expected_order_attributes)
      expect(current_user.reload.bonus_balance).to eq(80)
    end

    context "when order value is greater than bonus balance" do
      let(:price) { 2000 }
      let(:error_data) do
        {
          code: :payment_required,
          message: "You don't have enough bonus",
          status: 402
        }
      end

      it_behaves_like "failed interactor"

      it "did not creates order" do
        expect { interactor.run }.not_to change(Order, :count)
        expect(current_user.reload.bonus_balance).to eq(100)
      end
    end
  end

  describe "#after" do
    let(:order) { create :order }

    let(:initial_context) do
      {
        order: order
      }
    end

    context "when organizer succeeds" do
      include_context "with stubbed organizer"

      it "send notifications" do
        interactor.run
        expect(OrderCreatedNotificationJob).to have_been_enqueued.with(order.id)
      end
    end

    context "when organizer failures" do
      include_context "with stubbed organizer", failure: true

      it "does not invite user" do
        interactor.run
        expect(OrderCreatedNotificationJob).not_to have_been_enqueued
      end
    end
  end
end
