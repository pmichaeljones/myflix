class User < ActiveRecord::Base

  has_secure_password

  validates_presence_of :full_name, :email_address, :password_digest

end
