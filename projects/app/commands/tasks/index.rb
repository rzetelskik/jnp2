class Tasks::Index
  prepend SimpleCommand

  def initialize(project:)
    @project = project
  end

  def call
    tasks
  end

  private

  attr_accessor :project

  def tasks
    project.tasks
  end
end