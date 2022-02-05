class Statuses::Update
  prepend SimpleCommand

  def initialize(status:, name:)
    @status = status
    @name = name
  end

  def call
    update_status
  end

  private

  attr_accessor :status, :name

  def update_status
    return if status.update(name: name)

    errors.add_multiple_errors(status.errors.to_hash)
    nil
  end
end