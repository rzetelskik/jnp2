class Projects::Destroy
  prepend SimpleCommand

  def initialize(project:)
    @project = project
  end

  def call
    destroy
  end

  private

  attr_accessor :project

  def destroy
    return if project.destroy

    errors.add_multiple_errors(project.errors.to_hash)
    nil
  end
end