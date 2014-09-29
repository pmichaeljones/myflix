class ReviewsController < ApplicationController
  before_filter :require_user

  def create
    #binding.pry
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(review_params.merge!(user: current_user))
    #eview.user_id = current_user.id

    if @review.save
      flash[:info] = "Thanks for the review."
      redirect_to @video
    else
      @reviews = @video.reviews.reload
      flash[:danger] =  "Please write a review before submitting."
      render 'videos/show'
    end

  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end


end
