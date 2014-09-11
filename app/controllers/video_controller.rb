class VideoController < ApplicationController

  def show
    #binding.pry
    @video = Video.find(params[:id])
  end

  def search

  end


end
