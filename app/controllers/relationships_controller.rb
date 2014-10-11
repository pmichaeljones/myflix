class RelationshipsController < ApplicationController
  before_filter :require_user

  def index
    @relationships = current_user.following_relationships
  end

  def create
    leader = User.find(params[:id])
    relationship = Relationship.create(follower: current_user, leader: leader)

    if relationship.save
      flash[:notice] = "Friendship created!"
    else
      flash[:danger] = "Something went wrong."
    end

    redirect_to people_path
  end


  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy unless relationship.follower != current_user
    redirect_to people_path
  end

end
