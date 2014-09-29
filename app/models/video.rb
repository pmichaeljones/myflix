class Video < ActiveRecord::Base
  has_many :reviews, -> { order "created_at DESC" }
  belongs_to :category , foreign_key: 'category_id'

  validates_presence_of :title, :description

  def self.search_by_title(string)

    return [] if string == ""

    Video.where('title LIKE ?', "%" + string + "%").order("created_at ASC")

  end

end
