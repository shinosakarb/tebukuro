# rails g rspec:integration Event

require 'rails_helper'

RSpec.describe 'Events(イベントAPI)', type: :request do
  let(:user) { build_stubbed(:user) }
  let(:community) { FactoryGirl.create(:community) }

  describe 'GET community_events_path (events#index)' do

    let!(:events) { FactoryGirl.create_list(:event, 2, community: community) }
    let(:events_json_parse){[]}

    before do
      get community_events_path(community)
      2.times do |n|
        events_json_parse[n] = JSON.parse(events[n].to_json).except('updated_at', 'created_at')
      end
    end

    subject do
      JSON.parse(response.body)
    end

    context '正常系' do

      example 'ステータス200が返されること' do
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      example 'JSONに含まれるkeyが適切であること' do
        2.times do |i|
          expect(subject[i].keys.sort).to include_json(events_json_parse[i].keys.sort)
        end
      end

      example 'JSONに含まれる情報が適切であること' do
        2.times do |i|
          expect(subject[i]).to include_json(events_json_parse[i])
        end
      end

    end
  end


  describe 'POST /communities/:community_id/events' do
    let(:community_id) {community.id}
    let(:params) { {event: attributes_for(:event)} }
    let(:event) { FactoryGirl.build_stubbed(:event, community: community) }

    before do
      sign_in_with(user)
      allow(Community).to receive(:find).and_return(community)
      allow(community).to receive_message_chain('events.build').and_return(event)
      allow_any_instance_of(EventPolicy).to receive(:create?).and_return(true)
    end

    context 'success' do
      before do
        allow(event).to receive(:save).and_return(true)
      end

      example do
        subject
        expect(response).to have_http_status(:created)
      end
    end

    context 'failure' do
      before do
        allow(event).to receive(:save).and_return(false)
      end

      example do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET event_path (events#show)' do

    context '正常系' do
      let(:event) { FactoryGirl.create(:event, community: community) }
      let(:tickets) { FactoryGirl.create_list(:ticket, 5, event: event) }
      let(:event_json_parse){JSON.parse(event.to_json).except('id', 'created_at', 'updated_at')}

      before do
        post event_tickets_path(tickets, event)
        get event_path(event)
      end

      subject do
        JSON.parse(response.body)
      end

      example 'ステータス200が返ってくること' do
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      example 'JSONから適切なkeyを取得できること' do
        json_data = change_jsonapi_format_of(subject)
        expect(json_data.keys.sort).to include_json(event_json_parse.keys.sort)
      end

      example 'responseのidがイベントのidと一致していること' do
        expect(subject["data"]["id"]).to eq event.id.to_json
      end

    end

    context '異常系' do

      before do
        get event_path(community_id: community.id, id: 0)
      end

      context '存在しないイベントを取得する' do

        example 'エラーが返されること' do
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end


  describe 'PATCH /events/:id' do
    let(:event) { FactoryGirl.build_stubbed(:event, community: community) }
    let(:id) { event.id }
    let(:params) { {event: attributes_for(:event, name: 'hogehoge')} }

    before do
      sign_in_with(user)
      allow(Event).to receive(:find).and_return(event)
      allow_any_instance_of(EventPolicy).to receive(:update?).and_return(true)
    end

    context 'success' do
      before do
        allow(event).to receive(:update).and_return(true)
      end

      example do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    context 'failure' do
      before do
        allow(event).to receive(:update).and_return(false)
      end

      example do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end


  describe 'DELETE /events/:id' do
    let(:event) { FactoryGirl.build_stubbed(:event, community: community) }
    let(:id) { event.id }

    before do
      sign_in_with(user)
      allow(Event).to receive(:find).and_return(event)
      allow_any_instance_of(EventPolicy).to receive(:destroy?).and_return(true)
    end

    context 'success' do
      before do
        allow(event).to receive(:destroy).and_return(true)
      end

      example do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    context 'failure' do
      before do
        allow(event).to receive(:destroy).and_return(false)
      end

      example do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
