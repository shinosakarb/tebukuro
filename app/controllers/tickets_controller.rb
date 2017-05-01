class TicketsController < ApplicationController

  before_action :set_event,      only: [:index, :create]
  before_action :set_ticket,     only: [:show, :update, :destroy]

  def index
    @tickets = @event.tickets
    render json: @tickets
  end

  # paramsハッシュデータをPOSTする場合
  def create
    @ticket = @event.tickets.build(ticket_params)
    if @ticket.save
      # resource毎に使うシリアライザーを変えたいときはeach_serializerで指定する
      render json: @ticket, status: :created, location: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @ticket
  end

  def update
    if @ticket.update(ticket_params)
      render json: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @ticket.destroy
      render json: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  private
  def ticket_params
    params.require(:ticket).permit(:name, :cost, :quantity,
                                  :sale_starts_at, :sale_ends_at, :purchased)
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

end
