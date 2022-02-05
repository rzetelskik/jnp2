class Statuses::Create
  prepend SimpleCommand

  def initialize(project:, name:)
    @project = project
    @name = name
  end

  def call
    create_status
  end

  private

  attr_accessor :project, :name

  def create_status
    status = Status.new(project_id: project.id, name: name)
    return status if status.save

    errors.add_multiple_errors(status.errors.to_hash)
    nil
  end
end