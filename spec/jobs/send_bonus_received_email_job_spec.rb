require "rails_helper"

describe SendBonusReceivedEmailJob do
  include_context "with mail delivery stubbed"
  let(:bonus_transfer_id) { 570_242 }
  let!(:bonus_transfer) { create :bonus_transfer, id: bonus_transfer_id }

  before do
    allow(ApplicationMailer).to receive(:bonus_received).and_return(delivery)
  end

  it "calls interactor to create activity" do
    expect(ApplicationMailer).to receive(:bonus_received).with(bonus_transfer)

    described_class.perform_now(bonus_transfer_id)
  end
end
