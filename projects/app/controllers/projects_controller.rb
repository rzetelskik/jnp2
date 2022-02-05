class ProjectsController < ApplicationController
  before_action :set_project, only: [:assign, :unassign, :show, :destroy, :update]

  def create
    data = {
        name: params.require(:name),
        user: current_user
    }
    command = Projects::Create.call(data)
    if command.success?
      render_success(command.result.slice(:id), :created)
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  def assign
    data = {
        project: project,
        user: params.require(:user)
    }
    command = Projects::Assign.call(data)
    if command.success?
      render_no_content
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  def unassign
    data = {
        project: project,
        user: params.require(:user)
    }
    command = Projects::Unassign.call(data)
    if command.success?
      render_no_content
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  def index
    data = {
        user: current_user
    }
    command = Projects::Index.call(data)
    if command.success?
      render_success(command.result.select(:id, :name))
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  def show
    data = {
        project: project
    }
    command = Projects::Show.call(data)
    if command.success?
      render_success(command.result)
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  def destroy
    data = {
        project: project
    }
    command = Projects::Destroy.call(data)
    if command.success?
      render_no_content
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  def update
    data = {
        project: project,
        name: params.require(:name)
    }
    command = Projects::Update.call(data)
    if command.success?
      render_no_content
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  private

  attr_accessor :project

  def set_project
    @project = Project.find(params.require(:id))
  end
end
