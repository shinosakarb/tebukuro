# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Participant, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:event) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'method' do
    let(:user) { build(:user) }
    let(:event) { build(:event, quota: 1) }

    describe '#name' do
      let(:participant) { build(:participant, event: event, user: user) }
      subject { participant.name }
      it { is_expected.to eq(user.name) }
    end

    describe '#waitlisted?' do

      before do
        allow(event).to receive(:waitlisted_participant_ids).and_return([4, 5])
      end

      subject { participant.waitlisted? }

      context 'when waitlisted' do
        let(:participant) { build(:participant, event: event, id: 4) }

        it { is_expected.to eq(true) }
      end

      context 'when not waitlisted' do
        let(:participant) { build(:participant, event: event, id: 3) }

        it { is_expected.to eq(false) }
      end
    end
  end

  describe 'validation' do
    let(:user) { build(:user) }
    let(:event) { build(:event, quota: 1) }

    context 'event' do
      let(:participant) { event.participants.new(user: user) }

      before do
        allow(event).to receive(:within_deadline?).and_return(false)
        allow(event).to receive(:user_registered?).with(user).and_return(true)
      end

      example 'Can not join' do
        participant.valid?
        expect(participant).not_to be_valid
        expect(participant.errors.messages[:event_id]).to include('参加できません')
      end

      example 'User already registered' do
        participant.valid?
        expect(participant).not_to be_valid
        expect(participant.errors.messages[:event_id]).to include('登録済みです')
      end
    end
  end
end
