require 'rails_helper'

RSpec.describe CommunityPolicy do
  subject { described_class }

  permissions :update?, :destroy? do
    let(:user) { create(:user) }
    let(:user_community) do
      community = build(:community)
      community.owners.build(user: user)
      community.save
      community
    end
    let(:other_community) do
      community = build(:community)
      community.owners.build(user: create(:user))
      community.save
      community
    end

    it { expect(subject).to permit(user, user_community) }
    it { expect(subject).not_to permit(user, other_community) }
  end
end
