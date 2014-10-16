class User < ActiveRecord::Base
  include Tokenable

  has_many :reviews, -> { order("created_at DESC")}

  has_many :queue_items, -> { order('position') }

  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id

  has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id

  has_secure_password validations: false

  validates_presence_of :full_name, :email_address, :password

  validates_uniqueness_of :email_address

  def normalize_queue_item_positions
    queue_items.each_with_index do | queue_item, index|
      queue_item.update_attributes(position: index + 1)
    end
  end

  def follow(other_user)
    following_relationships.create(leader: other_user) unless self == other_user
  end

  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end

  def follows?(another_user)
    following_relationships.map(&:leader).include?(another_user)
  end

  def can_follow?(another_user)
    !(self.follows?(another_user) || self == another_user )
  end

end
