class Projects::Create
  prepend SimpleCommand

  def initialize(name:, user:)
    @name = name
    @user = user
  end

  def call
    create_project
  end

  private

  attr_accessor :user, :name

  def create_project
    project = Project.new(name: name)
    return project if project.save and assign(project)

    errors.add_multiple_errors(project.errors.to_hash)
    nil
  end

  def assign(project)
    assignment = ProjectAssignment.new(project_id: project.id, user: user, owner: true)
    return assignment if assignment.save

    errors.add_multiple_errors(assignment.errors.to_hash)
    nil
  end
end