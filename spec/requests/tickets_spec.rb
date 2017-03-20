# rails g rspec:integration Ticket

require 'rails_helper'

RSpec.describe 'Tickets(チケットAPI)', type: :request do

  let(:community) { FactoryGirl.create(:community) }
  let(:event) { FactoryGirl.create(:event, community: community) }

  describe 'GET event_tickets_path (tickets#index)' do

    let!(:tickets) { FactoryGirl.create_list(:ticket, 5, event: event) }
    let(:tickets_json_parse){[]}

    before do
      get event_tickets_path(event, tickets)
      5.times do |i|
        tickets_json_parse << JSON.parse(tickets[i].to_json).except('updated_at', 'created_at', 'community_id')
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
        5.times do |i|
          expect(subject[i].keys.sort).to include_json(tickets_json_parse[i].keys.sort)
        end
      end

      example 'JSONに含まれる情報が適切であること' do
        expect(subject).to include_unordered_json(tickets_json_parse)
      end
    end
  end


  describe 'POST event_tickets_path (tickets#create)' do

    context '正常系' do

      let(:dummy_ticket) { FactoryGirl.attributes_for(:ticket) }
      let(:ticket_params) { {ticket: dummy_ticket} }
      let(:ticket_json_parse){JSON.parse(dummy_ticket.to_json)}

      before do
        post event_tickets_path(event), params: ticket_params
      end

      subject do
        JSON.parse(response.body)
      end

      example 'ステータス201を返されること' do
        expect(response).to have_http_status(:created)
      end

      example 'チケットが作成されること' do
        expect do
          post event_tickets_path(event), params: ticket_params
        end.to change(Ticket, :count).by(1)
      end

      example 'JSONに含まれるkeyが適切であること' do
        expect(subject.except('id', 'event_id').keys.sort).to include_json(ticket_json_parse.keys.sort)
      end

      example 'JSONに含まれる情報が適切であること' do
        expect(subject['event_id']).to eq event['id']
        expect(subject.except('id', 'event_id')).to include_json(ticket_json_parse)
      end

    end


    context '異常系' do

      context 'nameが未記入' do
        let(:ticket_name_blank_params) { {ticket: FactoryGirl.attributes_for(:ticket, name: nil)} }
        before do
          post event_tickets_path(event), params: ticket_name_blank_params
        end

        subject do
          JSON.parse(response.body)
        end

        example 'エラーが返ってくること' do
          expect(subject).to be_has_key 'name'
        end
      end

      context 'costが未記入' do
        let(:ticket_cost_blank_params) { {ticket: FactoryGirl.attributes_for(:ticket, cost: nil)} }

        before do
          post event_tickets_path(event), params: ticket_cost_blank_params
        end

        subject do
          JSON.parse(response.body)
        end

        example 'エラーが返ってくること' do
          expect(subject).to be_has_key 'cost'
        end
      end

      context 'quantityが未記入' do
        let(:ticket_quantity_blank_params) { {ticket: FactoryGirl.attributes_for(:ticket, quantity: nil)} }
        before do
          post event_tickets_path(event), params: ticket_quantity_blank_params
        end

        subject do
          JSON.parse(response.body)
        end

        example 'エラーが返ってくること' do
          expect(subject).to be_has_key 'quantity'
        end

      end

    end

    context 'name, cost, quantityが未記入' do
      let(:ticket_blank_params) { {ticket: FactoryGirl.attributes_for(:ticket, name: nil, cost: nil, quantity: nil)} }
      before do
        post event_tickets_path(event), params: ticket_blank_params
      end

      subject do
        JSON.parse(response.body)
      end

      example 'エラーが帰ってくること' do
        expect(subject).to be_has_key 'name'
        expect(subject).to be_has_key 'cost'
        expect(subject).to be_has_key 'quantity'
      end
    end

  end


  describe 'GET ticket_path (tickets#show)' do

    context '正常系' do
      let(:ticket) { FactoryGirl.create(:ticket, event: event) }
      let(:ticket_json_parse){JSON.parse(ticket.to_json).except('created_at', 'updated_at', 'community_id')}

      before do
        get ticket_path(ticket)
      end

      subject do
        JSON.parse(response.body)
      end

      example 'ステータス200が返ってくること' do
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      example 'JSONから適切なkeyを取得できること' do
        expect(subject.keys.sort).to include_json(ticket_json_parse.keys.sort)
      end

      example 'JSONから適切な情報を取得できること' do
        expect(subject).to include_json(ticket_json_parse)
      end

    end

    context '異常系' do

      before do
        get ticket_path(event_id: event.id, id: 0)
      end

      context '存在しないチケットを取得する' do

        example 'エラーが返されること' do
          expect(response).not_to be_success
          expect(response.status).to eq 404
        end
      end
    end
  end


  describe 'PATCH ticket_path (tickets#update)' do

    let(:ticket) { FactoryGirl.create(:ticket, event: event) }

    before do
      @name = ticket.name
      @cost = ticket.cost
      @quantity = ticket.quantity
    end

    context '正常系' do

      context '有効なパラメータ(name)の場合' do

        before do
          patch ticket_path(ticket),
            params: {ticket: attributes_for(:ticket, name: 'hogehoge')}
        end

        example 'ステータス200が返ってくること' do
          expect(response.status).to eq 200
        end

        example 'データベースチケットが更新されること' do
          ticket.reload
          expect(ticket.name).to eq 'hogehoge'
        end

      end

      context '有効なパラメータ(cost)の場合' do

        before do
          patch ticket_path(ticket),
            params: {ticket: attributes_for(:ticket, cost: 300)}
        end

        example 'ステータス200が返ってくること' do
          expect(response.status).to eq 200
        end

        example 'データベースのチケットが更新されること' do
          ticket.reload
          expect(ticket.cost).to eq 300
        end

      end

      context '有効なパラメータ(quantity)の場合' do

        before do
          patch ticket_path(ticket),
            params: {ticket: attributes_for(:ticket, quantity: 7)}
        end

        example 'ステータス200が返ってくること' do
          expect(response.status).to eq 200
        end

        example 'データベースのチケットが更新されること' do
          ticket.reload
          expect(ticket.quantity).to eq 7
        end

      end

    end

    context '異常系' do

      context '無効なパラメータ(name)の場合' do

        before do
          patch ticket_path(ticket),
            params: {ticket: attributes_for(:ticket, name: nil)}
        end

        example 'ステータス422が返ってくること' do
          expect(response.status).to eq 422
        end

        example 'データベースのチケットは更新されないこと' do
          ticket.reload
          expect(ticket.name).to eq @name
        end

      end

      context '無効なパラメータ(cost)の場合' do

        before do
          patch ticket_path(ticket),
            params: {ticket: attributes_for(:ticket, cost: nil)}
        end

        example 'ステータス422が返ってくること' do
          expect(response.status).to eq 422
        end

        example 'データベースのチケットは更新されないこと' do
          ticket.reload
          expect(ticket.cost).to eq @cost
        end

      end

      context '無効なパラメータ(quantity)の場合' do

        before do
          patch ticket_path(ticket),
            params: {ticket: attributes_for(:ticket, quantity: nil)}
        end

        example 'ステータス422が返ってくること' do
          expect(response.status).to eq 422
        end

        example 'データベースのチケットは更新されないこと' do
          ticket.reload
          expect(ticket.quantity).to eq @quantity
        end

      end

      context '要求されたチケットが存在しない場合' do

        before do
          patch ticket_path(event_id: event.id, id: 0),
            params: {ticket: attributes_for(:ticket, cost: 300)}
        end

        example 'リクエストはRecordNotFoundとなること' do
          expect(response.status).to eq 404
        end
      end
    end

  end


  describe 'DELETE ticket_path (tickets#destroy)' do

    context '正常系' do

      let!(:ticket) { FactoryGirl.create(:ticket, event: event) }

      subject do
        delete ticket_path(ticket)
      end

      example 'ステータス200を返すこと' do
        subject
        expect(response.status).to eq 200
      end

      example 'DBから要求されたチケットが削除されること' do
        expect {subject}.to change(Ticket, :count).by(-1)
      end

    end

    context '異常系' do

      context '要求されたチケットが存在しない場合' do

        before do
          delete ticket_path(event_id: event.id, id: 0)
        end

        example 'ステータス404が返されること' do
          expect(response.status).to eq 404
        end

      end
    end
  end

end
