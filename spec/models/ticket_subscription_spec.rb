require 'rails_helper'

RSpec.describe TicketSubscription, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:ticket) }
    it { is_expected.to belong_to(:user) }
  end

  context 'validation' do
    describe 'presence' do
      it { is_expected.to validate_presence_of(:quantity) }
    end

    describe 'numericality' do
      it { is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than_or_equal_to(1) }
    end

    describe 'uniqueness' do
      subject { TicketSubscription.new(quantity: 1, user: create(:user)) }
      it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:ticket_id) }
    end
  end

  describe 'destroy' do
    let(:user) { create(:user) }
    let(:ticket) { create(:ticket, event: create(:event, community: create(:community))) }
    let!(:ticket_subscription) { user.ticket_subscriptions.create(ticket: ticket, quantity: 1) }

    subject { ticket_subscription.destroy }

    example do
      expect{ subject }.to change{TicketSubscription.count}.from(1).to(0)
    end
  end
end
