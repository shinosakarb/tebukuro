require 'rails_helper'

describe TicketSubscriptionSerializer, type: :serializer do
  describe 'data' do
    let(:ticket) { build_stubbed(:ticket) }
    let(:ticket_subscription) { build_stubbed(:ticket_subscription, ticket: ticket) }

    subject { serialize_with_json_api(ticket_subscription) }

    it do
      is_expected.to include_json(
        data: {
          id: ticket_subscription.id.to_s,
          attributes: {
            quantity: ticket_subscription.quantity
          },
          relationships: {
            ticket: {
              data: {
                id: ticket.id.to_s
              }
            }
          }
        }
      )
    end
  end
end
