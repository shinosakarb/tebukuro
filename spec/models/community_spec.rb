require "rails_helper"

RSpec.describe Community, type: :model do
  describe 'association' do
    it { is_expected.to have_many(:events) }
    it { is_expected.to have_many(:tickets).through(:events) }
  end

  describe 'presence' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe '::new_with_owners' do
    let(:subject) { Community.new_with_owners(new_params).owners }

    context 'not exist owners attributes' do
      let(:new_params) { nil }
      it { is_expected.to be_present }
      example 'user_id of owners is nil' do
        expect(subject.first.user_id).to be_nil
      end
    end
    context 'exist owners attributes' do
      let(:new_params) { {owners: {user_id: 1}} }
      it { is_expected.to be_present }
      example 'user_id of owners is 1' do
        expect(subject.first.user_id).to eq 1
      end
    end
  end
end
