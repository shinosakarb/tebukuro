# frozen_string_literal: true

require 'rails_helper'

describe UserParticipantSerializer, type: :serializer do
  let(:user) { build_stubbed(:user) }
  let(:event) { build_stubbed(:event, quota: 1) }
  let(:participant) { attributes_for(:participant, event: event, user: user) }
  let(:user_participant) { UserParticipant.new(event: event, current_user: user) }

  describe 'data' do
    subject { serialize(user_participant) }

    context 'with admitted registration' do
      before do
        event.participants.build(participant)
        allow(Participant)
          .to receive(:find_by).and_return(event.participants.first)
      end

      it {
        is_expected.to include_json(
          registered: true,
          on_waiting_list: false
        )
      }
    end

    context 'with waitlisted registration' do
      before do
        2.times { event.participants.build(participant) }
        allow(Participant)
          .to receive(:find_by).and_return(event.participants.second)
      end

      it {
        is_expected.to include_json(
          registered: true,
          on_waiting_list: true
        )
      }
    end
  end
end
