require 'rails_helper'

RSpec.describe "POST /tickets/:ticket_id/subscriptions", type: :request do
  let(:user) { create(:user) }
  let(:ticket) { build_stubbed(:ticket) }
  let(:ticket_id) { ticket.id }
  let(:headers) { user.create_new_auth_token }
  let(:current_user) { user }
  let(:ticket_subscription) { build_stubbed(:ticket_subscription, ticket: ticket) }

  before do
    allow(Ticket).to receive(:find).and_return(ticket)
    allow_any_instance_of(DeviseTokenAuth::Controllers::Helpers).to receive(:current_user).and_return(user)
    allow(user).to receive(:purchases).and_return(ticket_subscription)
  end

  context 'success' do
    before do
      allow(ticket_subscription).to receive(:save).and_return(true)
    end

    example do
      subject
      expect(response).to have_http_status(:created)
    end
  end

  context 'failure' do
    before do
      allow(ticket_subscription).to receive(:save).and_return(false)
    end

    example do
      subject
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
