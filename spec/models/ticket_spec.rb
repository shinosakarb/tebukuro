require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'association' do
    describe 'belongs to event' do
      it { is_expected.to belong_to(:event) }
    end

    describe 'has one community through event' do
      it { is_expected.to have_one(:community) }
    end

    describe 'has many ticket subscriptions' do
      it { is_expected.to have_many(:ticket_subscriptions) }
    end

    describe 'has many users through ticket subscriptions' do
      it { is_expected.to have_many(:users).through(:ticket_subscriptions) }
    end
  end

  describe 'validations' do
    describe '#name' do
      it { is_expected.to validate_presence_of(:name) }
    end

    describe '#cost' do
      it { is_expected.to validate_presence_of(:cost) }
      it {
        is_expected.to validate_numericality_of(:cost)
          .is_greater_than_or_equal_to(0)
      }
    end

    describe '#quantity' do
      it { is_expected.to validate_presence_of(:quantity) }
      it {
        is_expected.to validate_numericality_of(:quantity)
          .is_greater_than_or_equal_to(1)
      }
    end

    describe '#sale_starts_at' do
      it { is_expected.to validate_presence_of(:sale_starts_at) }
    end

    describe '#sale_ends_at' do
      it { is_expected.to validate_presence_of(:sale_ends_at) }
    end
  end
end
