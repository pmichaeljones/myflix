class CategoryController < ApplicationController

  def index
    @categories = Category.all
  end

end
