module ApplicationHelper

  def options_for_video_rating(queue_item)
    options_for_select([["5 Stars",5], ["4 Stars",4], ["3 Stars",3], ["2 Stars",2], ["1 Star",1]], queue_item.rating)
  end


  def average_rating(video)
    return "Not Yet Reviewed. Be the First!" if video.reviews.count == 0
    ratings = []
    video.reviews.each do |review|
      ratings << review.rating
    end
    "Average Rating: " + ((ratings.reduce(:+).to_f / ratings.size).round(1)).to_s + " Stars"
  end

end
