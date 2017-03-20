class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def not_found
    render json: { errors: 'Not found' }, status: :not_found
  end
end
