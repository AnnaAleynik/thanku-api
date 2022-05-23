require "rails_helper"

describe Products::Update do
  describe ".call" do
    include_context "with interactor"

    let(:initial_context) do
      {
        product_params: {
          id: product.id,
          name: "T-shirt",
          count: count
        }
      }
    end
    let(:count) { 10 }
    let(:product) { create :product }

    context "with valid data" do
      it_behaves_like "success interactor"

      it "updates product" do
        interactor.run

        expect(context.product).to have_attributes(
          name: "T-shirt",
          count: 10
        )
      end
    end

    context "with invalid data" do
      let(:count) { -1 }

      let(:error_data) do
        {
          message: "Record Invalid",
          detail: ["Count must be greater than or equal to 0"],
          status: 422
        }
      end

      it_behaves_like "failed interactor"
    end
  end
end
