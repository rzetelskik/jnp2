class Projects::Index
  prepend SimpleCommand

  def initialize(user:)
    @user = user
  end

  def call
    projects
  end

  private

  attr_accessor :user

  def projects
    Project.joins(:project_assignments).where(project_assignments: {user: user, active: true})
  end
end