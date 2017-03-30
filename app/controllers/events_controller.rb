class EventsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_community, only: [:index, :create]
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :build_event, only: [:create]
  before_action :authorize_event, only: [:create, :update, :destroy]

  def index
    @events = @community.events
    render json: @events
  end

  def create
    if @event.save
      render json: @event, status: :created, location: @event
    else
      render_error @event, :unprocessable_entity
    end
  end

  def show
    render json: @event, adapter: :json_api, include: 'tickets'
  end

  def update
    if @event.update(event_params)
      render json: @event, adapter: :json_api, include: 'tickets'
    else
      render_error @event, :unprocessable_entity
    end
  end

  def destroy
    if @event.destroy
      render json: @event
    else
      render_error @event, :unprocessable_entity
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :description,
                                  :event_starts_at, :event_ends_at, :address)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def build_event
    @event = @community.events.build(event_params)
  end

  def set_community
    @community = Community.find(params[:community_id])
  end

end
