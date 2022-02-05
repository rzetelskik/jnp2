class Tasks::Show
  prepend SimpleCommand

  def initialize(task:)
    @task = task
  end

  def call
    task.as_json.merge({assignees: task.task_assignments.pluck(:user)})
  end

  private

  attr_accessor :task
end