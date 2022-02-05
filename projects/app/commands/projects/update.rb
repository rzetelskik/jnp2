class Projects::Update
  prepend SimpleCommand

  def initialize(project:, name:)
    @project = project
    @name = name
  end

  def call
    update
  end

  private

  attr_accessor :project, :name

  def update
    return if project.update(name: name)

    errors.add_multiple_errors(project.errors.to_hash)
    nil
  end
end