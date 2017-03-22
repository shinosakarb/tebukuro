require 'rails_helper'

RSpec.describe Owner, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:community) }
    it { is_expected.to belong_to(:user) }
  end

  context 'validation' do
    describe 'uniqueness' do
      subject { Owner.new(user: create(:user)) }
      it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:community_id) }
    end
  end
end
