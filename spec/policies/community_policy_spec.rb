require 'rails_helper'

RSpec.describe CommunityPolicy do
  subject { described_class }

  permissions :update?, :destroy? do
    let(:user) { build_stubbed(:user) }
    let(:community) { build_stubbed(:community) }

    context "user's community" do
      before { allow(user).to receive(:owner?).and_return(true) }
      it { expect(subject).to permit(user, community) }
    end

    context 'other community' do
      before { allow(user).to receive(:owner?).and_return(false) }
      it { expect(subject).not_to permit(user, community) }
    end
  end
end
