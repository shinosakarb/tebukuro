require "rails_helper"

describe Event, type: :model do
  describe 'association' do
    it { is_expected.to have_many(:participants) }
    it { is_expected.to have_many(:tickets) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
  end

end
