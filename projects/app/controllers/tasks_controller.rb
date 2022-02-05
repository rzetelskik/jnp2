class TasksController < ApplicationController
  before_action :set_project, except: [:assign]
  before_action :set_task, only: [:assign, :destroy, :update, :show]

  def create
    data = {
        project: project,
        name: params.require(:name),
        description: params.require(:description),
        created_by: current_user,
        status_id: params&.dig(:status_id)
    }
    command = Tasks::Create.call(data)
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
    command = Tasks::Index.call(data)
    if command.success?
      render_success(command.result.select(:id, :name, :description, :status_id))
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  def assigned
    data = {
        project: project,
        user: current_user
    }
    command = Tasks::Assigned.call(data)
    if command.success?
      render_success(command.result)
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  def assign
    data = {
        task: task,
        users: params&.dig(:users)
    }
    command = Tasks::Assign.call(data)
    if command.success?
      render_success(command.result, :no_content)
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  def destroy
    data = {
        task: task
    }
    command = Tasks::Destroy.call(data)
    if command.success?
      render_no_content
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  def update
    data = {
        task: task,
        name: params.require(:name),
        description: params.require(:description),
        status_id: params&.dig(:status_id)
    }
    command = Tasks::Update.call(data)
    if command.success?
      render_no_content
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  def show
    data = {
        task: task
    }
    command = Tasks::Show.call(data)
    if command.success?
      render_success(command.result, :ok)
    else
      render_error(command.errors.full_messages.first, :bad_request)
    end
  end

  private

  attr_accessor :project, :task

  def set_project
    @project = Project.find(params.require(:project_id))
  end

  def set_task
    @task = Task.find(params.require(:id))
  end
end