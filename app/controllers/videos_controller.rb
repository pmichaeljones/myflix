class VideosController < ApplicationController

  def index
    #binding.pry
    @videos = Video.all
    @categories = Category.all
  end

  def show
    #binding.pry
    @video = Video.find(params[:id])
  end

  def search
    #binding.pry

    @results = Video.search_by_title(params[:input])

    render :results

  end


end
