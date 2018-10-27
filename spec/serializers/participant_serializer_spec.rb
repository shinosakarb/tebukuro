# frozen_string_literal: true

require 'rails_helper'

describe ParticipantSerializer, type: :serializer do
  let(:user) { build_stubbed(:user) }
  let(:event) { build_stubbed(:event) }
  let(:participant) { build_stubbed(:participant, event: event, user: user) }

  describe 'data' do
    subject { serialize(participant) }

    it do
      is_expected.to include_json(
        id: participant.id,
        event_id: participant.event_id,
        name: participant.user.name,
        on_waiting_list: participant.waitlisted?,
        checked_in: false
      )
    end
  end
end
