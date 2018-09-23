# frozen_string_literal: true

require 'acceptance_helper'

resource 'Registrations', type: :request do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  let(:user) { build_stubbed(:user) }
  let(:event) { build_stubbed(:event, :partial_event_detail_information) }
  let(:participant) { build_stubbed(:participant, user: user, event: event) }

  response_field :id, 'Event id'
  response_field :name, 'Event name'
  response_field :description, 'Event description'
  response_field :quota, 'quota'
  response_field :registered, 'registered'
  response_field :event_starts_at, 'event starts at'
  response_field :event_ends_at, 'event ends at'

  route '/events/:event_id/registrations', 'Registrations Collection' do
    post 'Create Registration' do
      let(:event_id) { event.id }

      before do
        allow(Participant).to receive(:new).and_return(participant)
        allow(Event).to receive(:find).and_return(event)
        sign_in_with(user)
      end

      context 'When saving is successful' do
        before do
          allow(participant).to receive(:save).and_return(true)
        end

        example_request 'Creating registration is success' do
          expect(response_status).to eq 200
        end
      end

      context 'When saving is fails' do
        before do
          allow(participant).to receive(:save).and_return(false)
        end

        example_request 'Creating registration is failure' do
          expect(response_status).to eq 422
        end
      end
    end

    delete 'Delete Registration' do
      let(:event_id) { event.id }

      before do
        allow(Participant).to receive(:find_by).and_return(participant)
        allow(Event).to receive(:find).and_return(event)
        sign_in_with(user)
      end

      context 'When saving is successful' do
        before do
          allow(participant).to receive(:destroy).and_return(true)
        end

        example_request 'Deleting registration is success' do
          expect(response_status).to eq 200
        end
      end

      context 'When saving is fails' do
        before do
          allow(participant).to receive(:destroy).and_return(false)
        end

        example_request 'Deleting registration is failure' do
          expect(response_status).to eq 422
        end
      end
    end
  end
end
