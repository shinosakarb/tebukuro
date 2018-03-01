require 'rails_helper'

RSpec.describe 'Participants API', type: :request do
  let(:user) { build_stubbed(:user) }
  let(:event) { build_stubbed(:event) }
  let(:participant) { build_stubbed(:participant, event: event, user: user) }

  describe 'POST /events/:event_id/participants' do
    let(:event_id) { event.id }
    let(:params) { { participant: attributes_for(:participant) } }

    before do
      sign_in_with(user)
      allow(Participant).to receive(:new).and_return(participant)
    end

    context 'success' do
      before do
        allow(participant).to receive(:save).and_return(true)
      end

      it { is_expected.to eq 201 }

    end

    context 'failure' do
      before do
        allow(participant).to receive(:save).and_return(false)
      end

      it { is_expected.to eq 422 }
    end
  end

  describe 'DELETE /events/:event_id/participants/:id' do
    let(:event_id) { event.id }
    let(:id) { participant.id }

    before do
      allow(Participant).to receive(:find).and_return(participant)
      sign_in_with(user)
    end

    context 'success' do
      before do
        allow(participant).to receive(:destroy).and_return(true)
      end

      it { is_expected.to eq 200 }
    end

    context 'failure' do
      before do
        allow(participant).to receive(:destroy).and_return(false)
      end

      it { is_expected.to eq 422 }
    end
  end
end
