# frozen_string_literal: true

require 'rails_helper'

describe ParticipantSerializer, type: :serializer do
  let(:event) { build_stubbed(:event) }
  let(:participant) { build_stubbed(:participant, event: event) }

  describe 'data' do
    subject { serialize(participant) }

    it do
      is_expected.to include_json(
        id: participant.id,
        event_id: participant.event_id,
        admitted: participant.admitted
      )
    end
  end
end
