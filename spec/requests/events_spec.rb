# rails g rspec:integration Event

require 'rails_helper'

RSpec.describe 'Events(イベントAPI)', type: :request do

  let(:community) { FactoryGirl.create(:community) }

  describe 'GET community_events_path (events#index)' do

    let!(:events) { FactoryGirl.create_list(:event, 2, community: community) }
    let(:events_json_parse){[]}

    before do
      get community_events_path(community)
      events_json_parse[0] = JSON.parse(events[0].to_json).except('updated_at', 'created_at')
      events_json_parse[1] = JSON.parse(events[1].to_json).except('updated_at', 'created_at')
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


  describe 'POST community_events_path (events#create)' do

    context '正常系' do

      # event_paramsのデータ型は全てstring型になるため、dummy_eventを用意しておく
      let(:dummy_event) { FactoryGirl.attributes_for(:event)}
      let(:event_params) { {event: dummy_event} }
      let(:event_json_parse){JSON.parse(dummy_event.to_json).except('id','community_id')}

      before do
        post community_events_path(community), params: event_params
      end

      subject do
        JSON.parse(response.body)
      end

      example 'ステータス201を返されること' do
        expect(response).to have_http_status(:created)
      end

      example 'イベントが作成されること' do
        expect do
          post community_events_path(community), params: event_params
        end.to change(Event, :count).by(1)
      end

      example 'JSONに含まれるkeyが適切であること' do
        expect(subject.except('id', 'community_id')).to include_json(event_json_parse)
      end

      example 'JSONに含まれる情報が適切であること' do
        expect(subject['community_id']).to eq community['id']
        expect(subject.except('id', 'community_id')).to include_json(event_json_parse)
      end

    end

    context '異常系' do

      context 'nameが未記入' do
        let(:event_name_blank_params) { {event: FactoryGirl.attributes_for(:event_name_blank)} }
        before do
          post community_events_path(community), params: event_name_blank_params
        end

        subject do
          JSON.parse(response.body)
        end

        example 'エラーが返ってくること' do
          expect(subject).to be_has_key 'name'
        end
      end

      context 'descriptionが未記入' do
        let(:event_description_blank_params) { {event: FactoryGirl.attributes_for(:event_description_blank)} }

        before do
          post community_events_path(community), params: event_description_blank_params
        end

        subject do
          JSON.parse(response.body)
        end

        example 'エラーが返ってくること' do
          expect(subject).to be_has_key 'description'
        end
      end

      context 'addressが未記入' do
        let(:event_address_blank_params) { {event: FactoryGirl.attributes_for(:event_address_blank)} }

        before do
          post community_events_path(community), params: event_address_blank_params
        end

        subject do
          JSON.parse(response.body)
        end

        example 'エラーが返ってくること' do
          expect(subject).to be_has_key 'address'
        end
      end

      context 'name, description, addressが未記入' do
        let(:event_blank_params) { {event: FactoryGirl.attributes_for(:event_blank)} }
        before do
          post community_events_path(community), params: event_blank_params
        end

        subject do
          JSON.parse(response.body)
        end

        example 'エラーが返ってくること' do
          expect(subject).to be_has_key 'name'
          expect(subject).to be_has_key 'description'
          expect(subject).to be_has_key 'address'
        end
      end
    end
  end


  describe 'GET event_path (events#show)' do

    context '正常系' do
      let(:event) { FactoryGirl.create(:event, community: community) }
      let(:event_json_parse){JSON.parse(event.to_json).except('created_at', 'updated_at')}

      before do
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
        expect(subject.keys.sort).to include_json(event_json_parse.keys.sort)
      end

      example 'JSONから適切な情報を取得できること' do
        expect(subject).to include_json(event_json_parse)
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


  describe 'PATCH event_path (events#update)' do

    let(:event) { FactoryGirl.create(:event, community: community) }

    before do
      @name = event.name
      @description = event.description
      @address = event.address
    end

    context '正常系' do

      context '有効なパラメータ(name)の場合' do

        before do
          patch event_path(event), params: {event: attributes_for(:event, name: 'hogehoge')}
        end

        example 'ステータス200が返ってくること' do
          expect(response.status).to eq 200
        end

        example 'name更新されること' do
          event.reload
          expect(event.name).to eq 'hogehoge'
        end

      end


      context '有効なパラメータ(description)の場合' do

        before do
          patch event_path(event), params: {event: attributes_for(:event, description: 'hogehoge')}
        end

        example 'ステータス200が返ってくること' do
          expect(response.status).to eq 200
        end

        example 'descriptionが更新されること' do
          event.reload
          expect(event.description).to eq 'hogehoge'
        end

      end

      context '有効なパラメータ(address)の場合' do

        before do
          patch event_path(event), params: {event: attributes_for(:event, address: 'hogehoge')}
        end

        example 'ステータス200が返ってくること' do
          expect(response.status).to eq 200
        end

        example 'addressが更新されること' do
          event.reload
          expect(event.address).to eq 'hogehoge'
        end

      end


    end

    context '異常系' do

      context '無効なパラメータ(name)の場合' do

        before do
          patch event_path(event), params: {event: attributes_for(:event, name: nil)}
        end

        example 'ステータス422が返ってくること' do
          expect(response.status).to eq 422
        end

        example 'DBのイベントは更新されないこと' do
          event.reload
          expect(event.name).to eq @name
        end

      end

      context '無効なパラメータ(description)の場合' do

        before do
          patch event_path(event), params: {event: attributes_for(:event, description: nil)}
        end

        example 'ステータス422が返ってくること' do
          expect(response.status).to eq 422
        end

        example 'DBのイベントは更新されないこと' do
          event.reload
          expect(event.description).to eq @description
        end

      end

      context '無効なパラメータ(address)の場合' do

        before do
          patch event_path(event), params: {event: attributes_for(:event, address: nil)}
        end

        example 'ステータス422が返ってくること' do
          expect(response.status).to eq 422
        end

        example 'イベントのaddressは更新されないこと' do
          event.reload
          expect(event.address).to eq @address
        end
      end

      context '要求されたイベントが存在しない場合' do

        before do
          patch event_path(community_id: community.id, id: 0), params: {event: attributes_for(:event, description: 'hogehoge')}
        end

        # TODO: eq('text/html')になる。相談の上修正するか決める
        example 'Content-Typeはtext/htmlであること' do
          expect(response.content_type).to eq('text/html')
        end

        example 'リクエストはRecordNotFoundとなること' do
          expect(response.status).to eq 404
        end
      end

    end

  end


  describe 'DELETE event_path (events#destroy)' do

    context '正常系' do

      let!(:event) { FactoryGirl.create(:event, community: community) }

      subject do
        delete event_path(event)
      end

      example 'ステータス200を返すこと' do
        subject
        expect(response.status).to eq 200
      end

      example 'DBから要求されたユーザーが削除されること' do
        expect {subject}.to change(Event, :count).by(-1)
      end

    end

    context '異常系' do

      context '要求されたイベントが存在しない場合' do

        before do
          delete event_path(community_id: community.id, id: 0)
        end

        # TODO: eq('text/html')になる。相談の上修正するか決める
        example 'Content-Typeはtext/htmlであること' do
          expect(response.content_type).to eq('text/html')
        end

        example 'ステータス404が返されること' do
          expect(response.status).to eq 404
        end

      end
    end
  end
end
