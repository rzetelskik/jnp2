class ApplicationController < ActionController::API
  include ApiHandler
  include ExceptionHandler

  before_action :authorize_request

  protected

  attr_reader :current_user

  private

  def authorize_request
    @current_user = authenticated
    render_error('Unauthorized', :unauthorized) && nil unless current_user.present?
  end

  def authenticated
    request.headers['Authenticated']
  end
end
