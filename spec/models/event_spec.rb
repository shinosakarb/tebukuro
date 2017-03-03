require "rails_helper"

describe Event do
  describe 'association' do
    it { is_expected.to belong_to(:community) }
    it { is_expected.to have_many(:tickets) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:event_starts_at) }
    it { is_expected.to validate_presence_of(:event_ends_at) }
    it { is_expected.to validate_length_of(:address).is_at_most(255) }
  end

end
