class Tasks::Assign
  prepend SimpleCommand
  extend Memoist

  def initialize(task:, users:)
    @task = task
    @users = users || []
  end

  def call
    assign
  end

  private

  attr_accessor :task, :users

  def assign
    TaskAssignment.where(user: (assigned - users)).destroy_all

    (users - assigned).all? do |user|
      assignment = TaskAssignment.new(task: task, user: user)

      errors.add_multiple_errors(assignment.errors.to_hash) && next unless assignment&.save
      notify(user: user)
    end
  end

  def assigned
    task.task_assignments.pluck(:user)
  end

  def notify(user:)
    data = {
        routing_key: user,
        resource: 'task',
        action: 'assign',
        payload: task
    }
    Services::Notifier.new(data).call
  end

  memoize :assigned
end