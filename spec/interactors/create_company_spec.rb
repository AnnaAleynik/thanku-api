require "rails_helper"

describe CreateCompany do
  include_context "with interactor"

  let(:initial_context) { { company_params: company_params } }

  describe ".call" do
    context "with valid data" do
      let(:company_params) do
        {
          name: "ITIS",
          description: "Decsription",
          bonus_amount: 500
        }
      end

      it_behaves_like "success interactor"

      it "creates company" do
        interactor.run

        expect(context.company).to be_persisted
        expect(context.company).to have_attributes(
          name: "ITIS",
          description: "Decsription",
          bonus_amount: 500
        )
      end
    end

    context "with invalid data" do
      let(:company_params) do
        { name: "" }
      end
      let(:error_data) do
        { message: "Record Invalid", detail: ["Name can't be blank"] }
      end

      it_behaves_like "failed interactor"
    end
  end
end
