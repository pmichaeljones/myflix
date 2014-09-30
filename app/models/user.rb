class User < ActiveRecord::Base
  has_many :reviews

  has_secure_password validations: false

  validates_presence_of :full_name, :email_address, :password_digest

  validates_uniqueness_of :email_address

  has_many :queue_items

end
