class SearchController < ApplicationController

  def input
    #binding.pry

    @results = Video.search_by_title(params[:input])

    render :results

  end


end
