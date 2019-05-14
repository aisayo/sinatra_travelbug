class User < ActiveRecord::Base
  has_secure_password
  has_many :trips
  validates_presence_of  :email, :password

end
