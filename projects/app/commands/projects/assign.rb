class Projects::Assign
  prepend SimpleCommand
  extend Memoist

  def initialize(project:, user:)
    @project = project
    @username = user
  end

  def call
    return unless user.present?

    (activate_existing_assignment || create_assignment) && notify
  end

  private

  attr_accessor :project, :username

  def user
    user = ::Services::Accounts::Models::User.find_by_username(username)

    errors.add(:base,"User not found in accounts") unless user.present?
    user&.username
  end

  def notify
    data = {
        routing_key: user,
        resource: 'project',
        action: 'assign',
        payload: project
    }
    Services::Notifier.new(data).call
  end

  def activate_existing_assignment
    assignment = ProjectAssignment.find_by(project_id: project.id, user: user)
    return nil if assignment.nil?

    errors.add_multiple_errors(assignment.errors.to_hash) unless assignment.activate
    assignment
  end

  def create_assignment
    assignment = ProjectAssignment.new(project_id: project.id, user: user)
    return assignment if assignment&.save

    errors.add_multiple_errors(assignment.errors.to_hash)
    nil
  end

  memoize :user
end