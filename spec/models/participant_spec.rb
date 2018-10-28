# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Participant, type: :model do
  let(:user) { build(:user) }
  let(:event) { build(:event, quota: 1) }


  describe 'association' do
    it { is_expected.to belong_to(:event) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'enum' do
    describe 'status' do
      it do
        is_expected.to define_enum_for(:status)
          .with(%i[not_checked_in checked_in])
      end
    end
  end

  describe 'method' do
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

    describe '#toggle_status!' do
      # Validations are executed for unpersisted models,
      # so mocking methods to pass these unexpected validation.
      before do
        allow(event).to receive(:within_deadline?).and_return(true)
        allow(event).to receive(:user_registered?).with(user).and_return(false)
      end

      context 'already checked in' do
        it 'toggle status to not_checked_in.' do
          participant = event.participants.new(user: user, status: :checked_in)
          participant.toggle_status
          expect(participant.status).to eq('not_checked_in')
        end
      end

      context 'not checked in yet' do
        it 'toggle status to checked_in.' do
          participant = event.participants.new(user: user)
          participant.toggle_status
          expect(participant.status).to eq('checked_in')
        end
      end
    end
  end

  describe 'validation' do
    context 'event' do
      let(:participant) { event.participants.new(user: user) }

      before do
        allow(event).to receive(:within_deadline?).and_return(false)
        allow(event).to receive(:user_registered?).with(user).and_return(true)
      end

      context 'on create' do
        example 'Can not join' do
          participant.valid?(:create)
          expect(participant.errors.messages[:event_id]).to include('参加できません')
        end

        example 'User already registered' do
          participant.valid?(:create)
          expect(participant.errors.messages[:event_id]).to include('登録済みです')
        end
      end

      context 'on update' do
        it 'not validate params.' do
          participant.valid?(:update)
          expect(participant.errors.messages[:event_id]).to eq([])
        end
      end
    end
  end
end
