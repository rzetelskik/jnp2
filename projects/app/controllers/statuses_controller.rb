class StatusesController < ApplicationController
  before_action :set_project

  def create
    data = {
        project: project,
        name: params.require(:name)
    }
    command = Statuses::Create.call(data)
    if command.success?
      render_success(command.result.slice(:id), :created)
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  def index
    data = {
        project: project
    }
    command = Statuses::Index.call(data)
    if command.success?
      render_success(command.result.select(:id, :name))
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  def update
    data = {
        status: Status.find(params.require(:id)),
        name: params.require(:name)
    }
    command = Statuses::Update.call(data)
    if command.success?
      render_no_content
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  def destroy
    data = {
        status: Status.find(params.require(:id))
    }
    command = Statuses::Destroy.call(data)
    if command.success?
      render_no_content
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  private

  attr_accessor :project

  def set_project
    @project = Project.find(params.require(:project_id))
  end
end