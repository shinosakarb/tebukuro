require "rails_helper"

RSpec.describe Community, type: :model do
  describe 'validation' do
    it { should have_many(:events) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
