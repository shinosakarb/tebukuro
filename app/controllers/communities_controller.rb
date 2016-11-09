class CommunitiesController < ApplicationController

  before_action :set_community, only: [:show, :update, :destroy]

  def index
    @communities = Community.all
    render json: @communities
  end

  def create
    @community = Community.new(community_params)
    if @community.save
      render json: @community, status: :created
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
    @community = Community.find(params)
  end

end
