class Register
  prepend SimpleCommand

  def initialize(username, password, password_confirmation)
    @username = username
    @password = password
    @password_confirmation = password_confirmation
  end

  def call
    user = create_user
    JsonWebToken.encode(username: user.username) if user
  end

  private

  attr_accessor :username, :password, :password_confirmation

  def create_user
    user = User.new(username: username, password: password, password_confirmation: password_confirmation)
    return user if user&.save && user.authenticate(password)

    errors.add_multiple_errors(user.errors.to_hash)
    nil
  end
end
