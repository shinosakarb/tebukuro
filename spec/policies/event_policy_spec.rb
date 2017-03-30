require 'rails_helper'

RSpec.describe EventPolicy do
  subject { described_class }

  permissions :create?, :update?, :destroy? do
    let(:user) { build_stubbed(:user) }
    let(:event) { build_stubbed(:event) }

    context "user's event of community" do
      before { allow(user).to receive(:owner?).and_return(true) }
      it { expect(subject).to permit(user, event) }
    end

    context 'other event of community' do
      before { allow(user).to receive(:owner?).and_return(false) }
      it { expect(subject).not_to permit(user, event) }
    end
  end
end
