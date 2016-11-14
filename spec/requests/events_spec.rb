# rails g rspec:integration Event

# TODO: communitiesモデルが追加されたらリクエストパス修正

require 'rails_helper'

RSpec.describe 'Events(イベントAPI)', type: :request do
  let(:community) { FactoryGirl.create(:community) }

  describe 'GET community_events_path (events#index)' do

    let!(:events) { FactoryGirl.create_list(:event, 2, community: community) }

    before do
      get community_events_path(community)
    end

    context '正常系' do

      example 'ステータス200が返されること' do
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      example 'JSONに含まれる情報が適切であること' do
        result = JSON.parse(response.body)
        expect(result.size).to eq events.count
        expect(result[0]['id']).to eq events[0].id
        expect(result[0]['name']).to eq events[0].name
        expect(result[0]['description']).to eq events[0].description
        expect(result[1]['id']).to eq events[1].id
        expect(result[1]['name']).to eq events[1].name
        expect(result[1]['description']).to eq events[1].description
      end

    end
  end


  describe 'POST community_events_path (events#create)' do

    context '正常系' do

      let(:event_params) { {event: FactoryGirl.attributes_for(:event)} }
      before do
        post community_events_path(community), params: event_params
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
        result = JSON.parse(response.body)
        expect(result).to have_key('id')
        expect(result).to have_key('name')
        expect(result).to have_key('description')
        expect(result).to have_key('community_id')

      end

      example 'JSONからイベント情報が取得できる' do
        result = JSON.parse(response.body)
        expect(result['name']).to eq(event_params[:event][:name])
        expect(result['description']).to eq(event_params[:event][:description])
      end

    end

    context '異常系' do

      context 'nameが未記入' do
        let(:event_name_blank_params) { {event: FactoryGirl.attributes_for(:event_name_blank)} }
        before do
          post community_events_path(community), params: event_name_blank_params
        end

        example 'エラーが返ってくること' do
          result = JSON.parse(response.body)
          expect(result['name']).to include ("can't be blank")
          expect(result['description']).to eq nil
        end
      end

      context 'descriptionが未記入' do
        let(:event_description_blank_params) { {event: FactoryGirl.attributes_for(:event_description_blank)} }
        before do
          post community_events_path(community), params: event_description_blank_params
        end

        example 'エラーが返ってくること' do
          result = JSON.parse(response.body)
          expect(result['name']).to eq nil
          expect(result['description']).to include ("can't be blank")
        end
      end

      context 'name, descriptionが未記入' do
        let(:event_blank_params) { {event: FactoryGirl.attributes_for(:event_blank)} }
        before do
          post community_events_path(community), params: event_blank_params
        end

        example 'エラーが返ってくること' do
          result = JSON.parse(response.body)
          expect(result).to include("name" => ["can't be blank"], "description" => ["can't be blank"])
        end
      end

    end

  end


  describe 'GET community_event_path (events#show)' do

    context '正常系' do
      let(:event) { FactoryGirl.create(:event, community: community) }
      before do
        get community_event_path(community, event)
      end

      example 'ステータス200が返ってくること' do
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      example 'JSONに含まれるキーが適切であること' do
        result = JSON.parse(response.body)
        expect(result).to have_key('id')
        expect(result).to have_key('name')
        expect(result).to have_key('description')
        expect(result).to have_key('community_id')

      end

      example 'JSONからイベントの情報を取得できること' do
        json = JSON.parse(response.body)
        expect(json['id']).to eq event.id
        expect(json['name']).to eq event.name
        expect(json['description']).to eq event.description
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
        expect(result).to have_key('id')
        expect(result).to have_key('name')
        expect(result).to have_key('description')
        expect(result).to have_key('community_id')

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
