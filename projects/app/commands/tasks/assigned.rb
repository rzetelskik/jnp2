class Tasks::Assigned
  prepend SimpleCommand

  def initialize(project:, user:)
    @project = project
    @user = user
  end

  def call
    assigned
  end

  private

  attr_accessor :project, :user

  def assigned
    Task.joins(:task_assignments).where(project_id: project.id, task_assignments: { user: user })
  end
end