class EventsController < ApplicationController

  before_action :load_community,  only: [:index, :create]
  before_action :load_event,      only: [:show, :update, :destroy]

  def index
    @events = @community.events
    render json: @events
  end


  # paramsハッシュデータをPOSTする場合
  def create
    @event = @community.events.build(event_params)
    if @event.save
      # resource毎に使うシリアライザーを変えたいときはeach_serializerで指定する
      render json: @event, status: :created, location: [@community, @event]
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end


  def show
    render json: @event
  end

  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @event.destroy
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :description)
  end

  def load_event
    @event = Event.find(params[:id])
  end

  def load_community
    @community = Community.find(params[:community_id])
  end

end
