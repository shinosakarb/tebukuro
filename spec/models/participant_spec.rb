require 'rails_helper'

RSpec.describe Participant, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:event) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'validation' do
    describe '#admitted' do
      let(:event) { build_stubbed(:event, quota: 1) }
      let(:participant) { build_stubbed(:participant, event: event) }

      subject { event }

      it 'calls event.admitted_patricipant? once.' do
        is_expected.to receive(:admitted_participant?).once.with(participant.id)
        participant.admitted
      end
    end
  end
end
