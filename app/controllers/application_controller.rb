class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def not_found(exception)
    model = build_not_found_model(exception.model)
    render_error(model, :not_found)
  end

  def build_not_found_model(model_name)
    model = model_name.classify.constantize.new
    model.errors.add(:id, 'Not found')
    model
  end

  def render_error(model, status)
    render json: model, status: status, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
  end
end
