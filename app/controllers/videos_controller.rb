class VideosController < ApplicationController

  before_filter :require_user

  def index
    #binding.pry
    @videos = Video.all
    @categories = Category.all
  end

  def show
    #binding.pry
    @review = Review.new
    @video = Video.find(params[:id])
    @reviews = @video.reviews
    #binding.pry
  end

  def search
    #binding.pry

    @results = Video.search_by_title(params[:input])

    render :results

  end


end
