require "rails_helper"

describe Products::Destroy do
  describe ".call" do
    include_context "with interactor"

    let(:initial_context) do
      {
        product_id: product.id
      }
    end
    let(:product) { create :product }

    context "with valid data" do
      it_behaves_like "success interactor"
    end
  end
end
