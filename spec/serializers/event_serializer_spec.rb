# frozen_string_literal: true

require 'rails_helper'

describe EventSerializer, type: :serializer do
  let(:user) { build_stubbed(:user) }
  let(:event) { build_stubbed(:event, :partial_event_detail_information) }

  describe 'data' do
    before do
      event.participants.build(
        attributes_for(:participant, event: event, user: user)
      )
      allow(Participant).to receive(:find_by).and_return(event.participants.first)
    end

    subject { serialize(event, scope: user, scope_name: :current_user) }

    it do
      is_expected.to include_json(
        name: event.name,
        description: event.description,
        quota: event.quota,
        event_starts_at: event.event_starts_at.iso8601(3),
        event_ends_at: event.event_ends_at.iso8601(3),
        within_deadline: event.within_deadline?,
        participants: [{
          event_id: event.participants[0].event_id,
          name: event.participants[0].user.name,
          on_waiting_list: event.participants[0].waitlisted?
        }],
        user_participation: {
          registered: true,
          on_waiting_list: false
        }
      )
    end
  end
end
