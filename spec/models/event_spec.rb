require "rails_helper"

describe Event do

  let(:community) { FactoryGirl.create(:community) }
  let(:event) { FactoryGirl.build(:event, community: community) }

  describe 'presence' do
    it { is_expected.to belong_to(:community) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:started_at) }
    it { is_expected.to validate_presence_of(:ended_at) }
  end

  describe '時間' do

    context '正常系' do

      example '開始時間は終了時間より前であって、作成時間より後であること' do
        expect(event).to be_valid
      end

    end

    context '異常系' do

      example '開始時間は了時間より後であること' do
        event.started_at = 5.hours.from_now
        expect(event).to be_invalid
      end

      example '作成時間より前であること' do
        event.started_at = 2.hours.ago
        expect(event).to be_invalid
      end

    end

  end

end
