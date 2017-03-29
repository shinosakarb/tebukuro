class CommunitiesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_community, only: [:show, :update, :destroy]
  before_action :authorize_community, only: [:update, :destroy]

  def index
    @communities = Community.all
    render json: @communities
  end

  def create
    @community = Community.new_with_owners(community_params.to_h.merge(owners: {user: current_user}))
    if @community.save
      render json: @community, status: :created, location: @community
    else
      render_error @community, :unprocessable_entity
    end
  end

  def show
    render json: @community
  end

  def update
    if @community.update(community_params)
      render json: @community
    else
      render_error @community, :unprocessable_entity
    end
  end

  def destroy
    if @community.destroy
      render json: @community
    else
      render_error @community, :unprocessable_entity
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
