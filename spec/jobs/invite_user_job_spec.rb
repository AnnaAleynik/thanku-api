require "rails_helper"

describe InviteUserJob do
  include_context "with mail delivery stubbed"
  let(:user_id) { 570_242 }

  before do
    allow(ApplicationMailer).to receive(:invite_user).and_return(delivery)
  end

  context "when user exists" do
    let!(:user) { create :user, :invited_not_accepted, id: user_id }

    it "calls interactor to create activity" do
      expect(ApplicationMailer).to receive(:invite_user).with(user)

      described_class.perform_now(user_id)
    end
  end

  context "when user does not exist" do
    it "raises" do
      expect { described_class.perform_now(user_id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
