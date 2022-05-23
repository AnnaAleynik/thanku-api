require "rails_helper"

describe Products::Create do
  describe ".call" do
    include_context "with interactor"

    let(:initial_context) do
      {
        current_user: current_user,
        product_params: {
          name: "T-shirt",
          count: count,
          price: price
        }
      }
    end
    let(:current_user) { create :user, company: company, role: "manager" }
    let(:company) { create :company }
    let(:price) { 100 }
    let(:count) { 10 }

    context "with valid data" do
      it_behaves_like "success interactor"

      it "creates user" do
        interactor.run

        expect(context.product).to be_persisted
        expect(context.product).to have_attributes(
          name: "T-shirt",
          count: 10,
          price: 100,
          company: company
        )
      end
    end

    context "with invalid data" do
      let(:price) { -1 }
      let(:count) { -1 }

      let(:error_data) do
        {
          message: "Record Invalid",
          detail: ["Price must be greater than or equal to 0", "Count must be greater than or equal to 0"],
          status: 422
        }
      end

      it_behaves_like "failed interactor"
    end
  end
end
