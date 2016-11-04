class EventsController < ApplicationController

  before_action :set_event, only: [:show, :update, :destroy]

  def index
    @events = Event.all
    render json: @events
  end


  # paramsハッシュデータをPOSTする場合
  def create
    @event = Event.new(event_params)
    if @event.save
      # resource毎に使うシリアライザーを変えたいときはeach_serializerで指定する
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end


  def show
    render json: @event
  end

  def update
    if @event.valid?
      if @event.update!(event_params)
        render json: @event
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    else
      render json: @event.errors
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
    params.require(:event).permit(
        :name,
        :description
    )
  end

  def set_event
    @event = Event.find(params[:id])
  end


end
