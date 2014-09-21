class User < ActiveRecord::Base

  has_secure_password validations: false

  validates_presence_of :full_name, :email_address, :password_digest

  validates_uniqueness_of :email_address

end
