require 'rails_helper'

RSpec.describe Participant, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:event) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'method' do
    describe '#admitted' do
      let(:event) { build(:event, quota: 1) }

      before do
        allow(event).to receive(:admitted_participant_ids).and_return([1, 2, 3])
      end

      subject { participant.admitted }
      context 'when admitted' do
        let(:participant) { build(:participant, event: event, id: 3) }

        it { is_expected.to eq(true) }
      end

      context 'when not admitted' do
        let(:participant) { build(:participant, event: event, id: 4) }

        it { is_expected.to eq(false) }
      end
    end
  end
end
