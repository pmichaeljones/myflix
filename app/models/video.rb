class Video < ActiveRecord::Base
  belongs_to :category , foreign_key: 'category_id'

  validates_presence_of :title, :description

  def self.search_by_title(string)

    return [] if string == ""

    result = Video.where('title LIKE ?', "%" + string + "%")
    result.sort_by  &:created_at

  end

end
