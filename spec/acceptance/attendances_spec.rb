# frozen_string_literal: true

require 'acceptance_helper'

resource 'Attendances', type: :request do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  let(:user) { build_stubbed(:user) }
  let(:event) { build_stubbed(:event, :partial_event_detail_information) }
  let(:participant) { build_stubbed(:participant, user: user, event: event) }

  patch '/participants/:id/attendances' do
    let(:id) { participant.id }

    before do
      allow(Participant).to receive(:find).and_return(participant)
      allow(Event).to receive(:find).and_return(event)
      allow(participant).to receive(:toggle_status)
      sign_in_with(user)
    end

    context 'When authorization to update is successful' do
      before { allow(user).to receive(:organizer?).and_return(true) }

      example_request 'Update check-in status' do
        expect(response_status).to eq(200)
      end
    end

    context 'When authorization to update is failure' do
      before { allow(user).to receive(:organizer?).and_return(false) }

      example_request 'Update check-in status' do
        expect(response_status).to eq(403)
      end
    end
  end
end
