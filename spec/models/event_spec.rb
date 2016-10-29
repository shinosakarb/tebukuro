require "spec_helper"

describe Event do
  describe 'validation' do
    subject { event }

    context 'when valid' do
      let(:event) { Event.create(name: 'test event', description: 'test description') }
      it { is_expected.to be_valid }
    end

    context 'when empty name' do
      let(:event) { Event.create(name: nil, description: 'test description') }
      it { is_expected.to_not be_valid }
    end

    context 'when empty description' do
      let(:event) { Event.create(name: 'test event', description: nil) }
      it { is_expected.to_not be_valid }
    end
  end
end
