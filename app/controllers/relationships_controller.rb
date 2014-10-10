class RelationshipsController < ApplicationController
  before_filter :require_user

  def index
    @relationships = current_user.following_relationships
  end

  def destroy
    redirect_to people_path
  end

end
