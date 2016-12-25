# rails g rspec:integration Event

require 'rails_helper'

RSpec.describe 'Events(イベントAPI)', type: :request do

  event_keys = [:id, :name, :description, :community_id,
                :invitation_starts_at, :invitation_ends_at,
                :event_starts_at, :event_ends_at,
                :number_of_accepted_participants, :cost]
  event_keys_without_id = event_keys.reject{|key| key = 'id'}

  let(:community) { FactoryGirl.create(:community) }

  describe 'GET community_events_path (events#index)' do

    let!(:events) { FactoryGirl.create_list(:event, 2, community: community) }
    let(:events_json_parse){[]}

    before do
      get community_events_path(community)
      events_json_parse[0] = JSON.parse(events[0].to_json)
      events_json_parse[1] = JSON.parse(events[1].to_json)
    end

    subject do
      JSON.parse(response.body)
    end

    context '正常系' do

      example 'ステータス200が返されること' do
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      example 'JSONに含まれる情報が適切であること' do
        2.times do |i|
          event_keys.each do |key|
            expect(subject[i]["#{key}"]).to eq events_json_parse[i]["#{key}"]
          end
        end
      end
    end
  end


  describe 'POST community_events_path (events#create)' do

    context '正常系' do

      # event_paramsのデータ型は全てstring型になるため、dummy_eventを用意しておく
      let(:dummy_event) { FactoryGirl.attributes_for(:event)}
      let(:event_params) { {event: dummy_event} }
      let(:event_json_parse){JSON.parse(dummy_event.to_json)}

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

      example 'JSONに含まれるキーが適切であること' do
        event_keys.each do |key|
          expect(subject).to have_key("#{key}")
        end

      end

      example 'JSONからイベント情報が取得できる' do
        # evnet_paramsではdate型がstringになっているから、それと同じデータをもつdummy_eventを使う
        event_keys_without_id.each do |key|
          if (key == 'community_id')
            expect(subject["#{key}"]).to eq community['id']
          else
            expect(subject["#{key}"]).to eq event_json_parse["#{key}"]
          end
        end
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

      context 'name, descriptionが未記入' do
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
        end
      end
    end
  end


  describe 'GET community_event_path (events#show)' do

    context '正常系' do
      let(:event) { FactoryGirl.create(:event, community: community) }
      let(:event_json_parse){ JSON.parse(event.to_json)}

      before do
        get community_event_path(community, event)
      end

      subject do
        JSON.parse(response.body)
      end

      example 'ステータス200が返ってくること' do
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      example 'JSONに含まれるキーが適切であること' do
        event_keys.each do |key|
          expect(subject).to have_key("#{key}")
        end
      end

      example 'JSONからイベントの情報を取得できること' do
        event_keys.each do |key|
          expect(subject["#{key}"]).to eq event_json_parse["#{key}"]
        end
      end

    end

    context '異常系' do

      before do
        get community_event_path(community_id: community.id, id: 0)
      end

      context '存在しないイベントを取得する' do

        example 'エラーが返されること' do
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end


  describe 'PATCH community_event_path (events#update)' do

    let(:event) { FactoryGirl.create(:event, community: community) }

    before do
      @name = event.name
      @description = event.description
    end

    context '正常系' do

      context '有効なパラメータ(name)の場合' do

        before do
          patch community_event_path(community, event), params: {event: attributes_for(:event, name: 'hogehoge')}
        end

        example 'ステータス200が返ってくること' do
          expect(response.status).to eq 200
        end

        example 'データベースのユーザーが更新されること' do
          event.reload
          expect(event.name).to eq 'hogehoge'
        end

      end


      context '有効なパラメータ(description)の場合' do

        before do
          patch community_event_path(community, event), params: {event: attributes_for(:event, description: 'hogehoge')}
        end

        example 'ステータス200が返ってくること' do
          expect(response.status).to eq 200
        end

        example 'データベースのユーザーが更新されること' do
          event.reload
          expect(event.description).to eq 'hogehoge'
        end

      end


    end

    context '異常系' do

      context '無効なパラメータ(name)の場合' do

        before do
          patch community_event_path(community, event), params: {event: attributes_for(:event, name: nil)}
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
          patch community_event_path(community, event), params: {event: attributes_for(:event, description: nil)}
        end

        example 'ステータス422が返ってくること' do
          expect(response.status).to eq 422
        end

        example 'DBのイベントは更新されないこと' do
          event.reload
          expect(event.description).to eq @description
        end

      end

      context '要求されたイベントが存在しない場合' do

        before do
          patch community_event_path(community_id: community.id, id: 0), params: {event: attributes_for(:event, description: 'hogehoge')}
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


  describe 'DELETE community_event_path (events#destroy)' do

    context '正常系' do

      let!(:event) { FactoryGirl.create(:event, community: community) }

      subject do
        delete community_event_path(community, event)
      end

      example 'ステータス200を返すこと' do
        subject
        expect(response.status).to eq 200
      end

      example 'DBから要求されたユーザーが削除されること' do
        expect {subject}.to change(Event, :count).by(-1)
      end

      example 'JSONに含まれるキーが適切であること' do
        subject
        result = JSON.parse(response.body)
        event_keys.each do |key|
          expect(result).to have_key("#{key}")
        end

      end

    end

    context '異常系' do

      context '要求されたイベントが存在しない場合' do

        before do
          delete community_event_path(community_id: community.id, id: 0)
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
