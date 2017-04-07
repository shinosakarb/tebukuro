class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError,   with: :not_allowed

  def self.inherited(subclass)
    super
    authorize_name = subclass.controller_name.singularize
    define_method("authorize_#{authorize_name}") { authorize instance_variable_get("@#{authorize_name}") }
  end

  protected

  def not_found(exception)
    model = build_error_model(exception.model, :id, 'Not found')
    render_error(model, :not_found)
  end

  def not_allowed(exception)
    model = build_error_model(exception.record.class.to_s, :id, 'Not allowed')
    render_error(model, :forbidden)
  end

  def build_error_model(model_name, attribute, message)
    model = model_name.classify.constantize.new
    model.errors.add(attribute, message)
    model
  end

  def render_error(model, status)
    render json: model, status: status, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
  end
end
