require "spec_helper"

describe Community do
  describe 'validation' do
    let(:community) { Community.create(name: nil, description: nil) }
    before do
    community
    end

    it { community.name be_valid }
    it { community.description be_valid }
  end
end
