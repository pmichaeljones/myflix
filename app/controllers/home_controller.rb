class HomeController < ApplicationController

  def index
    #binding.pry
    @videos = Video.all
    @categories = Category.all
  end

end
