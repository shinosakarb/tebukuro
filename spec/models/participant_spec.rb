require 'rails_helper'

RSpec.describe Participant, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:event) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'method' do
    describe '.admitted' do
      let(:quota) { 3 }
      let(:event) { create(:event, quota: quota) }
      let(:participant) { create(:participant, event: event) }

      subject { participant.admitted }

      context 'when the participant is admitted' do
        before do
          create_list(:participant, quota - 1, event: event)
        end

        it { is_expected.to eq(true) }
      end

      context 'the participant has to wait for cancellation' do
        before do
          create_list(:participant, quota, event: event)
        end

        it { is_expected.to eq(false) }
      end
    end
  end
end
