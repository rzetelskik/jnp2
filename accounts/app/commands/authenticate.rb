class Authenticate
  prepend SimpleCommand

  def initialize(username, password)
    @username = username
    @password = password
  end

  def call
    @user = _user
    JsonWebToken.encode(username: user.username) if user
  end

  private

  attr_accessor :username, :password, :user

  def _user
    found_user = User.find(username)
    return found_user if found_user && found_user.authenticate(password)

    errors.add(:user_authentication, 'invalid credentials')
    nil
  end
end
