require "rails_helper"

RSpec.describe Community, type: :model do
  describe 'association' do
    it { is_expected.to have_many(:events) }
  end

  describe 'presence' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
