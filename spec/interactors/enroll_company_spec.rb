require "rails_helper"

describe EnrollCompany do
  describe "#after" do
    include_context "with mail delivery stubbed"

    let(:company) { create :company }
    let(:user_id) { 213_689 }
    let(:user) { create :user, :manager, id: user_id, company: company }
    let(:initial_context) { { user: user, company: company } }
    let(:event) { :user_registered }

    before do
      allow(ApplicationMailer).to receive(:confirm_user).and_return(delivery)
    end

    context "when organizer succeeds" do
      include_context "with stubbed organizer"

      it_behaves_like "activity source"
      it "schedules email job" do
        expect(ApplicationMailer).to receive(:confirm_user)
        interactor.run
      end
    end

    context "when organizer failures" do
      include_context "with stubbed organizer", failure: true

      it "does not schedule create activity job" do
        interactor.run
        expect(RegisterActivityJob).not_to have_been_enqueued
        expect(ApplicationMailer).not_to receive(:confirm_user)
      end
    end
  end
end
