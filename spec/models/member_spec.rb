require "rails_helper"

describe Event do
  describe 'validation' do
    it { is_expected.to belong_to(:community) }
    it { is_expected.to validate_presence_of(:name) }
  end
end
