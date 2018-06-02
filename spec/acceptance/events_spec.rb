# frozen_string_literal: true

require 'acceptance_helper'

def document_event_params
  with_options :scope => :event do
    parameter :name, "Event name"
    parameter :description, "Event description"
    parameter :event_starts_at, 'Event starts at'
    parameter :event_ends_at, 'Event ends at'
    parameter :address, 'Event address'
    parameter :quota, 'Event quota'
  end
end

resource 'Event' do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let(:events) { build_stubbed_list(:event, 2) }
  let(:event) { build_stubbed(:event) }
  
  response_field :id, 'Event id'
  response_field :name, 'Event name'
  response_field :description, 'Event description'
  response_field :quota, 'quota'
  response_field :registered, 'registered'
  response_field :event_starts_at, 'Event starts at'
  response_field :event_ends_at, 'Event ends at'
  response_field :participants, 'Participants Collection'
  
  route '/events', 'Events Collection' do
    get 'Returns all events' do
      before do
        allow(Event).to receive(:all).and_return(events)
      end

      example_request 'Getting all events' do
        expect(response_status).to eq 200
      end
    end

    post 'Create event' do
      document_event_params
      let(:params) { {event: attributes_for(:event)} }
      let(:raw_post) { params.to_json }

      before do
        allow(Event).to receive(:new).and_return(event)
      end

      context 'When saving is successful' do
        before do
          allow(event).to receive(:save).and_return(true)
        end

        example_request 'Creating event is success' do
          expect(response_status).to eq 201
        end
      end

      context 'When saving is fails' do
        before do
          allow(event).to receive(:save).and_return(false)
        end
  
        example_request 'Createing event is failure' do
          expect(response_status).to eq 422
        end
      end
    end
  end

  route '/events/:id', 'Event' do
    let(:id) { 1 }

    get 'Return event' do
      context 'When an event can be found' do
        before do
          allow(Event).to receive(:find).and_return(event)
        end

        example_request 'Getting event is success' do
          expect(response_status).to eq 200
        end
      end

      context 'When an event can not be found' do
        before do
          allow(Event).to receive(:find).and_raise(ActiveRecord::RecordNotFound.new('stub', 'Event'))
        end

        example_request 'Getting event is failure' do
          expect(response_status).to eq 404
        end
      end
    end

    patch 'Update event' do
      document_event_params
      let(:params) { {event: attributes_for(:event, name: 'hogehoge')} }
      let(:raw_post) { params.to_json }

      before do
        allow(Event).to receive(:find).and_return(event)
      end

      context 'When the update successful' do
        before do
          allow(event).to receive(:update).and_return(true)
        end

        example_request 'Updating event is success' do
          expect(response_status).to eq 200
        end
      end

      context 'When the update fails' do
        before do
          allow(event).to receive(:update).and_return(false)
        end

        example_request 'Updating event is failure' do
          expect(response_status).to eq 422
        end
      end
    end

    delete 'Delete event' do
      before do
        allow(Event).to receive(:find).and_return(event)
      end

      context 'When the delete successful' do
        before do
          allow(event).to receive(:destroy).and_return(true)
        end

        example_request 'Deleting event is success' do
          expect(response_status).to eq 200
        end
      end

      context 'When the delete fails' do
        before do
          allow(event).to receive(:destroy).and_return(false)
        end

        example_request 'Deleting event is failure' do
          expect(response_status).to eq 422
        end
      end
    end
  end
end
