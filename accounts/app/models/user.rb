class User < ApplicationRecord
  self.primary_key = 'username'
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
end
