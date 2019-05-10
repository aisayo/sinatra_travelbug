class User < ActiveRecord::Base
  has_secure_password
  has_many :trips
  validates :username, :email, uniqueness: true, presence :true

  
end
