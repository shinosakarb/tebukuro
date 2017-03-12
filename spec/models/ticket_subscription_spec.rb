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
  end
end
