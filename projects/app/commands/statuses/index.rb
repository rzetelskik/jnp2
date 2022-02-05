class Statuses::Index
  prepend SimpleCommand

  def initialize(project:)
    @project = project
  end

  def call
    statuses
  end

  private

  attr_accessor :project

  def statuses
    project.statuses
  end
end