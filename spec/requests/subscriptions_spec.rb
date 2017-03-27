require 'rails_helper'

RSpec.describe "POST /tickets/:ticket_id/subscriptions", type: :request do
  let(:user) { build_stubbed(:user) }
  let(:ticket) { build_stubbed(:ticket) }
  let(:ticket_id) { ticket.id }
  let(:ticket_subscription) { build_stubbed(:ticket_subscription, ticket: ticket) }

  before do
    sign_in_with(user)
    allow(Ticket).to receive(:find).and_return(ticket)
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
