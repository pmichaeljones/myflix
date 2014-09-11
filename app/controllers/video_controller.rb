class VideoController < ApplicationController

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
