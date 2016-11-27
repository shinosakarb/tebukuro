require "rails_helper"

describe Event do

  let(:community) { FactoryGirl.create(:community) }

  describe 'presence' do
    it { is_expected.to belong_to(:community) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:started_at) }
    it { is_expected.to validate_presence_of(:ended_at) }
  end

  describe '時間' do

    context '正常系' do

      let(:event) { FactoryGirl.create(:event, community: community) }

      example '開始時間は終了時間より前であって、作成時間より後であること' do
        expect(event).to be_valid
      end

    end

    context '異常系' do

      let(:event) { FactoryGirl.create(:event, community: community) }
      before do
        event.ended_at = 2.days.ago
      end
      example '開始時間は終了時間より後であること' do
        expect(event).to be_invalid
      end

      let(:event) { FactoryGirl.create(:event, community: community) }
      before do
        event.started_at = 2.days.ago
      end
      example '作成時間より前であること' do
        expect(event).to be_invalid
      end

    end

  end

end
