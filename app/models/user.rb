class User < ActiveRecord::Base
  has_secure_password
  has_many :trips
  validates_presence_of :password 
  validates :email, :presence => true,
                    :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }


end
