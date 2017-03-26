class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket

  def create
    purchase_ticket = current_user.purchases @ticket

    if purchase_ticket.save
      render json: purchase_ticket, status: :created
    else
      render_error purchase_ticket, :unprocessable_entity
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end
end
