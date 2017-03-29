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
          expect(response).to have_http_status(:unprocessable_entity)
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

  describe 'PATCH /communities/:id' do
    let(:user) { build_stubbed(:user) }
    let(:community) { build_stubbed(:community) }
    let(:id) { community.id }
    let(:params) { {community: attributes_for(:community, name: 'hogehoge')} }

    before do
      sign_in_with(user)
      allow(Community).to receive(:find).and_return(community)
      allow_any_instance_of(CommunityPolicy).to receive(:update?).and_return(true)
    end

    context 'success' do
      before do
        allow(community).to receive(:update).and_return(true)
      end

      example do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    context 'failure' do
      before do
        allow(community).to receive(:update).and_return(false)
      end

      example do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

  end


  describe 'DELETE /communities/:id' do
    let(:user) { build_stubbed(:user) }
    let(:community) { build_stubbed(:community) }
    let(:id) { community.id }

    before do
      sign_in_with(user)
      allow(Community).to receive(:find).and_return(community)
      allow_any_instance_of(CommunityPolicy).to receive(:destroy?).and_return(true)
    end

    context 'success' do
      before do
        allow(community).to receive(:destroy).and_return(true)
      end

      example do
        subject
        expect(response).to have_http_status(:ok)
      end
    end

    context 'failure' do
      before do
        allow(community).to receive(:destroy).and_return(false)
      end

      example do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
