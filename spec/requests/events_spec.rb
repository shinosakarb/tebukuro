# rails g rspec:integration Event

require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Events(イベントAPI)', type: :request do
  include Committee::Test::Methods

  describe 'GET /events (events#index)' do

    let(:events) { FactoryGirl.create_list(:event, 2) }

    subject do
      get "/events", events: events
    end

    context '正常系' do

      it 'Content-Typeはapplication/jsonであること' do
        subject
        expect(response.content_type).to eq('application/json')
      end

      it 'ステータス200が返されること' do
        subject
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      it 'JSONに含まれる情報が適切であること' do
        subject
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


  # paramsをPOSTする場合
  describe 'POST /events (events#create)' do

    let(:event) { FactoryGirl.create(:event) }
    let(:event_params) { {event: FactoryGirl.attributes_for(:event)} }

    subject do
      post "/events", params: event_params
    end

    context '正常系' do

      it 'Content-Typeはapplication/jsonであること' do
        subject
        expect(response.content_type).to eq('application/json')
      end

      it 'ステータス200を返されること' do
        subject
        expect(response).to be_success
      end

      it 'イベントが作成されること' do
        expect { subject }.to change(Event, :count).by(1)
      end

      it 'JSONに含まれるキーが適切であること' do
        subject
        result = JSON.parse(response.body)
        expect(result).to have_key('id')
        expect(result).to have_key('name')
        expect(result).to have_key('description')
        expect(result).to have_key('community_id')

      end

      it 'JSONからイベント情報が取得できる' do
        subject
        result = JSON.parse(response.body)
        expect(result['name']).to eq(event.name)
        expect(result['description']).to eq(event.description)
      end

    end

    context '異常系' do

      context 'nameが未記入' do
        let(:event_name_blank) { FactoryGirl.build(:event_name_blank) }
        let(:event_name_blank_params) { {event: FactoryGirl.attributes_for(:event_name_blank)} }
        before do
          post '/events', params: event_name_blank_params
        end

        it 'Content-Typeはapplication/jsonであること' do
          expect(response.content_type).to eq('application/json')
        end

        it 'エラーが返ってくること' do
          result = JSON.parse(response.body)
          expect(result['name']).to eq ["can't be blank"]
          expect(result['description']).to eq nil
        end
      end

      context 'descriptionが未記入' do
        let(:event_description_blank) { FactoryGirl.build(:event_description_blank) }
        let(:event_description_blank_params) { {event: FactoryGirl.attributes_for(:event_description_blank)} }
        before do
          post '/events', params: event_description_blank_params
        end

        it 'Content-Typeはapplication/jsonであること' do
          expect(response.content_type).to eq('application/json')
        end

        it 'エラーが返ってくること' do
          result = JSON.parse(response.body)
          expect(result['name']).to eq nil
          expect(result['description']).to eq ["can't be blank"]
        end
      end

      context 'name, descriptionが未記入' do
        let(:event_blank) { FactoryGirl.build(:event_blank) }
        let(:event_blank_params) { {event: FactoryGirl.attributes_for(:event_blank)} }
        before do
          post '/events', params: event_blank_params
        end

        it 'Content-Typeはapplication/jsonであること' do
          expect(response.content_type).to eq('application/json')
        end

        it 'エラーが返ってくること' do
          result = JSON.parse(response.body)
          expect(result['name']).to eq ["can't be blank"]
          expect(result['description']).to eq ["can't be blank"]
        end
      end

    end

  end


  describe 'GET /events/:id (events#show)' do

    let(:event) { FactoryGirl.create(:event) }

    subject do
      get event_path(event)
    end

    context '正常系' do

      it 'Content-Typeはapplication/jsonであること' do
        subject
        expect(response.content_type).to eq('application/json')
      end

      it 'ステータス200が返ってくること' do
        subject
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      it 'JSONに含まれるキーが適切であること' do
        subject
        result = JSON.parse(response.body)
        expect(result).to have_key('id')
        expect(result).to have_key('name')
        expect(result).to have_key('description')
        expect(result).to have_key('community_id')

      end

      it 'JSONからイベントの情報を取得できること' do
        subject
        json = JSON.parse(response.body)
        expect(json['id']).to eq event.id
        expect(json['name']).to eq event.name
        expect(json['description']).to eq event.description
      end

    end

    context '異常系' do

      before do
        get '/events/0'
      end

      context '存在しないイベントを取得する' do

        it 'エラーが返されること' do
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end

      end

    end

  end


  describe 'PATCH /events/:id (events#update)' do

    let(:event) { FactoryGirl.create(:event) }
    before do
      @name = event.name
      @description = event.description
    end

    context '正常系' do

      context '有効なパラメータ(name)の場合' do

        before do
          patch "/events/#{event.id}", event: attributes_for(:event, name: 'hogehoge')
        end

        it 'Content-Typeはapplication/jsonであること' do
          expect(response.content_type).to eq('application/json')
        end

        it 'ステータス200が返ってくること' do
          expect(response.status).to eq 200
        end

        it 'データベースのユーザーが更新されること' do
          event.reload
          expect(event.name).to eq 'hogehoge'
        end

      end


      context '有効なパラメータ(description)の場合' do

        before do
          patch "/events/#{event.id}", event: attributes_for(:event, description: 'hogehoge')
        end

        it 'Content-Typeはapplication/jsonであること' do
          expect(response.content_type).to eq('application/json')
        end

        it 'ステータス200が返ってくること' do
          expect(response.status).to eq 200
        end

        it 'データベースのユーザーが更新されること' do
          event.reload
          expect(event.description).to eq 'hogehoge'
        end

      end


    end

    context '異常系' do

      context '無効なパラメータ(name)の場合' do

        before do
          patch "/events/#{event.id}", event: attributes_for(:event, name: nil)
        end

        it 'Content-Typeはapplication/jsonであること' do
          expect(response.content_type).to eq('application/json')
        end

        it 'ステータス422が返ってくること' do
          expect(response.status).to eq 422
        end

        it 'DBのイベントは更新されないこと' do
          event.reload
          expect(event.name).to eq @name
        end

      end

      context '無効なパラメータ(description)の場合' do

        before do
          patch "/events/#{event.id}", event: attributes_for(:event, description: nil)
        end

        it 'Content-Typeはapplication/jsonであること' do
          expect(response.content_type).to eq('application/json')
        end

        it 'ステータス422が返ってくること' do
          expect(response.status).to eq 422
        end

        it 'DBのイベントは更新されないこと' do
          event.reload
          expect(event.description).to eq @description
        end

      end

      context '要求されたイベントが存在しない場合' do

        before do
          patch "/events/hogehoge", event: attributes_for(:event, description: 'hogehoge')
        end

        it 'Content-Typeはapplication/jsonであること' do
          expect(response.content_type).to eq('application/json')
        end

        it 'リクエストはRecordNotFoundとなること' do
          expect(response.status).to eq 404
        end
      end

    end

  end


  describe 'DELETE /events/:id (events#destroy)' do

    # letだと上手くいかない。(itが一つしかなければうまくいく)
    # let!だと毎回処理される
    let!(:event){FactoryGirl.create(:event)}

    context '正常系' do

      subject do
        delete "/events/#{event.id}", event: event
      end

      it 'Content-Typeはapplication/jsonであること' do
        subject
        expect(response.content_type).to eq('application/json')
      end

      it 'ステータス200を返すこと' do
        subject
        expect(response.status).to eq 200
      end

      it 'DBから要求されたユーザーが削除されること' do
        expect{subject}.to change(Event, :count).by(-1)
      end

      it 'JSONに含まれるキーが適切であること' do
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
          delete '/events/hogehoge'
        end

        it 'Content-Typeはapplication/jsonであること' do
          expect(response.content_type).to eq('application/json')
        end

        it 'ステータス404が返されること' do
          expect(response.status).to eq 404
        end

      end
    end

  end

end
