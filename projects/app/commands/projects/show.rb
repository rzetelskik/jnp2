class Projects::Show
  prepend SimpleCommand

  def initialize(project:)
    @project = project
  end

  def call
    project.as_json.merge({ assignees: project.project_assignments.pluck(:user, :owner) })
  end

  private

  attr_accessor :project
end