module ApplicationHelper

  def average_rating(video)

    return "Not Yet Reviewed. Be the First!" if video.reviews.count == 0

    ratings = []

    video.reviews.each do |review|
      ratings << review.rating
    end

    "Average Rating: " + ((ratings.reduce(:+).to_f / ratings.size).round(1)).to_s + " Stars"

  end

end
