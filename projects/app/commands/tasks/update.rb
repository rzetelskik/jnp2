class Tasks::Update
  prepend SimpleCommand

  def initialize(task:, name:, description:, status_id: nil)
    @task = task
    @name = name
    @description = description
    @status_id = status_id
  end

  def call
    update_task
  end

  private

  attr_accessor :task, :name, :description, :status_id

  def update_task
    return if task.update(name: name, description: description, status_id: status_id)

    errors.add_multiple_errors(task.errors.to_hash)
    nil
  end
end