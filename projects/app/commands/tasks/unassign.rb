class Tasks::Unassign
  prepend SimpleCommand

  def initialize(task:, user:)
    @task = task
    @user = user
  end

  def call
    unassign
  end

  private

  attr_accessor :task, :user

  def unassign
    assignment = task.task_assignments.find_by_user(user)
    return if assignment&.destroy

    errors.add(:base, 'User is not assigned to this task')
    nil
  end
end