require "rails_helper"

describe Orders::ChangeProductQuantity do
  include_context "with interactor"

  let(:initial_context) do
    {
      order: order,
      product: product
    }
  end
  let(:product) { create :product, count: 1 }
  let(:order) { build :order, quantity: quantity }

  describe ".call" do
    context "when order quantity is equal product count" do
      let(:quantity) { 1 }

      it_behaves_like "success interactor"
      it "change product quantity" do
        interactor.run

        expect(product.count).to eq(0)
      end
    end

    context "when order quantity is greater than product count" do
      let(:quantity) { 200 }
      let(:error_data) do
        {
          message: "We don't have enough products. Try later.",
          status: 422
        }
      end

      it_behaves_like "failed interactor"
    end
  end
end
