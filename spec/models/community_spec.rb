require "rails_helper"

RSpec.describe Community, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end
end
