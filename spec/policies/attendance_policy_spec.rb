# frozen_string_literal: true

require 'rails_helper'

describe AttendancePolicy do
  let(:user) { build_stubbed(:user) }

  subject { described_class }

  permissions :update? do
    context 'user is the organizer of event' do
      it 'grants access if user is the organizer of event.' do
        event = build_stubbed(:event, organizer: user)
        participant = build_stubbed(:participant, event: event, user: user)
        expect(subject).to permit(user, participant)
      end
    end

    context 'user is not the organizer of event' do
      it 'denies access.' do
        event = build_stubbed(:event)
        participant = build_stubbed(:participant, event: event, user: user)
        expect(subject).not_to permit(user, participant)
      end
    end
  end
end
