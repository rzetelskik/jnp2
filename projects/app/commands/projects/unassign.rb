class Projects::Unassign
  prepend SimpleCommand
  extend Memoist

  def initialize(project:, user:)
    @project = project
    @username = user
  end

  def call
    return unless user.present?

    deactivate(assignment)
  end

  private

  attr_accessor :project, :username

  def user
    user = ::Services::Accounts::Models::User.find_by_username(username)

    errors.add(:base,"User not found in accounts") unless user.present?
    user&.username
  end

  def assignment
    assignment = ProjectAssignment.find_by(project_id: project.id, user: user)
    errors.add(:base, "User has not been assigned yet") if assignment.nil?

    assignment
  end

  def deactivate(assignment)
    errors.add_multiple_errors(assignment.errors.to_hash) unless assignment&.deactivate
  end

  memoize :user
end