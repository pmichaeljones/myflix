class HomeController < ApplicationController

  def index
    #binding.pry
    @videos = Video.all
  end

end
