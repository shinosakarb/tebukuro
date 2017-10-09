require 'rails_helper'

describe TicketSubscriptionSerializer, type: :serializer do
  describe 'data' do
    let(:ticket) { build_stubbed(:ticket) }
    let(:ticket_subscription) { build_stubbed(:ticket_subscription, ticket: ticket) }

    subject { serialize(ticket_subscription) }

    it do
      is_expected.to include_json(
        id: ticket_subscription.id,
        quantity:  ticket_subscription.quantity,
        ticket: {
          id: ticket.id,
          name: ticket.name
        }
      )
    end
  end
end
