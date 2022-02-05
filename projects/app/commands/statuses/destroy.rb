class Statuses::Destroy
  prepend SimpleCommand

  def initialize(status:)
    @status = status
  end

  def call
    destroy
  end

  private

  attr_accessor :status

  def destroy
    return if status.destroy

    errors.add_multiple_errors(status.errors.to_hash)
  end
end