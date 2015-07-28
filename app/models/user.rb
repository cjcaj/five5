class User < ActiveRecord::Base
  validates :name, presence: true
  validates :username, presence: true, uniqueness:true
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, on: :create
  self.per_page = 5
end

