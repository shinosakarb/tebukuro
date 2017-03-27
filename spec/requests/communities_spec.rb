require 'rails_helper'

RSpec.describe 'Communities(コミュニティーAPI)', type: :request do
  describe 'GET communities_path (communities#index)' do

    let!(:communities) { FactoryGirl.create_list(:community, 2) }

    before do
      get communities_path
    end

    context '正常系' do

      example 'ステータス200が返されること' do
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      example 'JSONに含まれる情報が適切であること' do
        result = JSON.parse(response.body)
        expect(result.size).to eq communities.count
        expect(result[0]['id']).to eq communities[0].id
        expect(result[0]['name']).to eq communities[0].name
        expect(result[0]['description']).to eq communities[0].description
        expect(result[1]['id']).to eq communities[1].id
        expect(result[1]['name']).to eq communities[1].name
        expect(result[1]['description']).to eq communities[1].description
      end

    end

  end


  describe 'POST communities_path (communities#create)' do
    let(:user) { create(:user) }

    before do
      sign_in_with(user)
    end

    context '正常系' do

      let(:community_params) { {community: FactoryGirl.attributes_for(:community)} }
      before do
        post communities_path, params: community_params
      end

      example 'ステータス201を返されること' do
        expect(response).to have_http_status(:created)
      end

      example 'コミュニティーが作成されること' do
        expect(Community.count).to eq 1
        expect(Owner.count).to eq 1
      end

      example 'JSONに含まれるキーが適切であること' do
        result = JSON.parse(response.body)
        expect(result).to have_key('id')
        expect(result).to have_key('name')
        expect(result).to have_key('description')
      end

      example 'JSONからコミュニティー情報が取得できる' do
        result = JSON.parse(response.body)
        expect(result['name']).to eq(community_params[:community][:name])
        expect(result['description']).to eq(community_params[:community][:description])
      end

    end


    context '異常系' do

      context 'nameが未記入' do

        let(:community_name_blank_params) { {community: FactoryGirl.attributes_for(:community, name: nil)} }
        before do
          post communities_path, params: community_name_blank_params
        end

        example 'エラーが返ってくること' do
          result = JSON.parse(response.body)
          expect(result).to be_has_key 'name'
        end

      end

      context 'descriptionが未記入' do

        let(:community_description_blank_params) { {community: FactoryGirl.attributes_for(:community, description: nil)} }
        before do
          post communities_path, params: community_description_blank_params
        end

        example 'エラーが返ってくること' do
          result = JSON.parse(response.body)
          expect(result).to be_has_key 'description'
        end

      end

      context 'name, descriptionが未記入' do

        let(:community_blank_params) { {community: FactoryGirl.attributes_for(:community, name: nil, description: nil)} }
        before do
          post communities_path, params: community_blank_params
        end

        example 'エラーが返ってくること' do
          result = JSON.parse(response.body)
          expect(result).to be_has_key 'name'
          expect(result).to be_has_key 'description'
        end

      end

    end

  end


  describe 'GET community_path (communities#show)' do

    context '正常系' do

      let(:community) { FactoryGirl.create(:community) }
      before do
        get community_path(community)
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
      end

      example 'JSONからコミュニティーの情報を取得できること' do
        json = JSON.parse(response.body)
        expect(json['id']).to eq community.id
        expect(json['name']).to eq community.name
        expect(json['description']).to eq community.description
      end

    end

    context '異常系' do

      before do
        get community_path(id: 0)
      end

      context '存在しないコミュニティーを取得する' do

        example 'エラーが返されること' do
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end

      end

    end

  end

  describe 'PATCH community_path (communities#update)' do

    let(:community) { FactoryGirl.create(:community) }
    before do
      @name = community.name
      @description = community.description
    end

    context '正常系' do

      context '有効なパラメータ(name)の場合' do

        before do
          patch community_path(community), params: {community: attributes_for(:community, name: 'hogehoge')}
        end

        example 'ステータス200が返ってくること' do
          expect(response.status).to eq 200
        end

        example 'データベースのユーザーが更新されること' do
          community.reload
          expect(community.name).to eq 'hogehoge'
        end

      end

      context '有効なパラメータ(description)の場合' do

        before do
          patch community_path(community), params: {community: attributes_for(:community, description: 'hogehoge')}
        end

        example 'ステータス200が返ってくること' do
          expect(response.status).to eq 200
        end

        example 'データベースのユーザーが更新されること' do
          community.reload
          expect(community.description).to eq 'hogehoge'
        end

      end

    end

    context '異常系' do

      context '無効なパラメータ(name)の場合' do

        before do
          patch community_path(community), params: {community: attributes_for(:community, name: nil)}
        end

        example 'ステータス422が返ってくること' do
          expect(response.status).to eq 422
        end

        example 'DBのコミュニティーは更新されないこと' do
          community.reload
          expect(community.name).to eq @name
        end

      end

      context '無効なパラメータ(description)の場合' do

        before do
          patch community_path(community), params: {community: attributes_for(:community, description: nil)}
        end

        example 'ステータス422が返ってくること' do
          expect(response.status).to eq 422
        end

        example 'DBのコミュニティーは更新されないこと' do
          community.reload
          expect(community.description).to eq @description
        end

      end

      context '要求されたコミュニティーが存在しない場合' do

        before do
          patch community_path(id: 0), params: {community: attributes_for(:community, description: 'hogehoge')}
        end

        example 'リクエストはRecordNotFoundとなること' do
          expect(response.status).to eq 404
        end

      end

    end

  end


  describe 'DELETE community_path (communities#destroy)' do

    context '正常系' do

      let!(:community) { FactoryGirl.create(:community) }
      subject do
        delete community_path(community)
      end

      example 'ステータス200を返すこと' do
        subject
        expect(response.status).to eq 200
      end

      example 'DBから要求されたユーザーが削除されること' do
        expect {subject}.to change(Community, :count).by(-1)
      end

      example 'JSONに含まれるキーが適切であること' do
        subject
        result = JSON.parse(response.body)
        expect(result).to have_key('id')
        expect(result).to have_key('name')
        expect(result).to have_key('description')
      end

    end

    context '異常系' do

      context '要求されたコミュニティーが存在しない場合' do

        before do
          delete community_path(id: 0)
        end

        example 'ステータス404が返されること' do
          expect(response.status).to eq 404
        end

      end

    end

  end

end
