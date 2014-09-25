class Review < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  default_scope { order('created_at DESC')}
end