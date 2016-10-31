require "spec_helper"

describe Community do
  describe 'validation' do
    subject { community }

    context 'when valid' do
      let(:community) { Community.create(name: 'test community', description: 'test description') }
      it { is_expected.to be_valid }
    end

    context 'when empty name' do
      let(:community) { Community.create(name: nil, description: 'test description') }
      it { is_expected.to_not be_valid }
    end

    context 'when empty description' do
      let(:community) { Community.create(name: 'test community', description: nil) }
      it { is_expected.to_not be_valid }
    end
  end
end
