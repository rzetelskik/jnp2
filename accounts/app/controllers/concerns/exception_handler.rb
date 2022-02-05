module ExceptionHandler
  extend ActiveSupport::Concern
  include ApiHandler

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render_error(e, :not_found)
    end

    rescue_from ActionController::ParameterMissing do |e|
      render_error(e, :bad_request)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render_error(e, :unprocessable_entity)
    end
  end
end