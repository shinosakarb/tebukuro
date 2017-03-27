class Subscription::TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket
  before_action :set_subscription_ticket

  def destroy
    @subscription_ticket.destroy
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def set_subscription_ticket
    @subscription_ticket = current_user.ticket_subscriptions.find_by!(ticket: @ticket)
  end
end
