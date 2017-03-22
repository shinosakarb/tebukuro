class CommunitiesController < ApplicationController

  before_action :authenticate_user!, only: [:create]
  before_action :set_community, only: [:show, :update, :destroy]

  def index
    @communities = Community.all
    render json: @communities
  end

  # paramsハッシュデータをPOSTする場合
  def create
    @community = Community.new(community_params)
    if @community.save
      # resource毎に使うシリアライザーを変えたいときはeach_serializerで指定する
      render json: @community, status: :created, location: @community
    else
      render json: @community.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @community
  end

  def update
    if @community.update(community_params)
      render json: @community
    else
      render json: @community.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @community.destroy
      render json: @community
    else
      render json: @community.errors, status: :unprocessable_entity
    end
  end

  private
  def community_params
    params.require(:community).permit(:name, :description)
  end

  def set_community
    @community = Community.find(params[:id])
  end

end
