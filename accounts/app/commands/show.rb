class Show
  prepend SimpleCommand

  def initialize(user:)
    @user = user
  end

  def call
    user.slice(:username)
  end

  private

  attr_accessor :user
end
