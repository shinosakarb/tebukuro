require "spec_helper"

describe Event do
  describe 'validation' do
    let(:event) { Event.create(name: "test event", description: "test description") }

    it { expect(event).to be_valid }
  end
end
