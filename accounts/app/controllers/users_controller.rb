class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def authenticate
    command = Authenticate.call(params.require(:username), params.require(:password))
    if command.success?
      render_success({ auth_token: command.result })
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  def authorize
    command = Authorize.call(request.headers)
    if command.success?
      response.set_header("Authenticated", command.result.username)
      render_no_content
    else
      render_error(command.errors.full_messages.first, :unauthorized)
    end
  end

  def register
    command = Register.call(params.require(:username), params.require(:password), params.require(:password_confirmation))
    if command.success?
      render_success({ auth_token: command.result })
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  def show
    command = Show.call(user: user)
    if command.success?
      render_success({user: command.result})
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  private

  attr_accessor :user

  def set_user
    @user = User.find(params.require(:username))
  end
end
