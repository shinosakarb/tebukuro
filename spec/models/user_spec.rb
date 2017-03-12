require 'rails_helper'

describe User, type: :model do
  describe 'association' do
    it { is_expected.to have_many(:ticket_subscriptions) }
    it { is_expected.to have_many(:tickets).through(:ticket_subscriptions) }
  end
end
