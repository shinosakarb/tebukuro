# frozen_string_literal: true

require 'rails_helper'

describe EventSerializer, type: :serializer do
  let(:user) { build_stubbed(:user) }
  let(:event) { build_stubbed(:event) }

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
        user_participation: {
          registered: event.user_registered?(user),
          on_waiting_list: false
        },
        event_starts_at: event.event_starts_at,
        event_ends_at: event.event_ends_at,
        participants: [{
          event_id: event.participants[0].event_id,
          name: event.participants[0].user.name,
          on_waiting_list: event.participants[0].waitlisted?
        }]
      )
    end
  end
end
