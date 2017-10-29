require 'rails_helper'

RSpec.describe 'Events API', type: :request do
  let(:events) { FactoryGirl.build_stubbed_list(:event, 2) }
  let(:event) { FactoryGirl.build_stubbed(:event) }

  describe 'GET /events' do
    before do
      allow(Event).to receive(:all).and_return(events)
    end

    it { is_expected.to eq 200 }
  end

  describe 'POST /events' do
    let(:params) { {event: attributes_for(:event)} }

    before do
      allow(Event).to receive(:new).and_return(event)
    end

    context 'success' do
      before do
        allow(event).to receive(:save).and_return(true)
      end

      it { is_expected.to eq 201 }
    end

    context 'failure' do
      before do
        allow(event).to receive(:save).and_return(false)
      end

      it { is_expected.to eq 422 }
    end
  end

  describe 'GET /events/:id' do
    let(:id) { 1 }

    context 'success' do
      before do
        allow(Event).to receive(:find).and_return(event)
      end

      it { is_expected.to eq 200 }
    end

    context 'failure' do
      before do
        allow(Event).to receive(:find).and_raise(ActiveRecord::RecordNotFound.new('stub', 'Event'))
      end

      it { is_expected.to eq 404 }
    end
  end


  describe 'PATCH /events/:id' do
    let(:params) { {event: attributes_for(:event, name: 'hogehoge')} }
    let(:id) { 1 }

    before do
      allow(Event).to receive(:find).and_return(event)
    end

    context 'success' do
      before do
        allow(event).to receive(:update).and_return(true)
      end

      it { is_expected.to eq 200 }
    end

    context 'failure' do
      before do
        allow(event).to receive(:update).and_return(false)
      end

      it { is_expected.to eq 422 }
    end
  end


  describe 'DELETE /events/:id' do
    let(:id) { 1 }
    
    before do
      allow(Event).to receive(:find).and_return(event)
    end

    context 'success' do
      before do
        allow(event).to receive(:destroy).and_return(true)
      end

      it { is_expected.to eq 200 }
    end

    context 'failure' do
      before do
        allow(event).to receive(:destroy).and_return(false)
      end

      it { is_expected.to eq 422 }
    end
  end
end
