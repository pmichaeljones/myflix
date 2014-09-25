class ReviewsController < ApplicationController

  def create
    review = Review.new(review_params)
    review.rating = params[:rating]
    review.user = current_user
    review.video_id = params[:id]
    binding.pry

    if review.save
      flash[:info] = "Thanks for the review."
      redirect_to :back
    else
      redirect_to :back
    end

  end


  private

  def review_params
    params.require(:review).permit(:body)
  end
end
