require "rails_helper"

describe Orders::PrepareParams do
  describe ".call" do
    include_context "with interactor"

    let(:initial_context) do
      {
        current_company: current_company,
        current_user: current_user,
        order_params: {
          product_id: product.id,
          quantity: 1,
          price: 50,
          comment: "Yellow"
        }
      }
    end
    let(:current_company) { current_user.company }
    let(:current_user) { create :user }
    let(:product) { create :product, company: current_company }

    it_behaves_like "success interactor"

    it "prepare params" do
      interactor.run

      expect(context.product).to be_persisted
      expect(context.product).to eq(product)
      expect(context.order).to have_attributes(
        {
          status: "created",
          product: product,
          quantity: 1,
          price: 50,
          comment: "Yellow"
        }
      )
    end
  end
end
