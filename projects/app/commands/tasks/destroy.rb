class Tasks::Destroy
  prepend SimpleCommand

  def initialize(task:)
    @task = task
  end

  def call
    destroy
  end

  private

  attr_accessor :task

  def destroy
    return if task.destroy

    errors.add_multiple_errors(task.errors.to_hash)
  end
end