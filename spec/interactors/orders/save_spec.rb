require "rails_helper"

describe Orders::Save do
  include_context "with interactor"

  let(:initial_context) do
    {
      order: order
    }
  end
  let(:order) { build :order, price: 100, quantity: 1, comment: "Yellow" }

  describe ".call" do
    context "with valid data" do
      it_behaves_like "success interactor"

      it "create new order" do
        expect { interactor.run }.to change(Order, :count).from(0).to(1)

        expect(context.order).to have_attributes(
          {
            quantity: 1,
            price: 100,
            comment: "Yellow"
          }
        )
      end
    end
  end
end
