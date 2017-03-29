require 'rails_helper'

describe User, type: :model do
  describe 'association' do
    it { is_expected.to have_many(:ticket_subscriptions) }
    it { is_expected.to have_many(:tickets).through(:ticket_subscriptions) }
  end

  describe '#owner?' do
    let(:user) { create(:user) }
    subject{ user.owner? community }

    context 'other community' do
      let(:community) do
        community = build(:community)
        community.owners.build(user: create(:user))
        community.save
        community
      end

      it { is_expected.to eq false }
    end

    context "user's community" do
      let(:community) do
        community = build(:community)
        community.owners.build(user: user)
        community.save
        community
      end

      it { is_expected.to eq true }
    end
  end
end
