class PasswordResetsController < ApplicationController

  def show
    @token = params[:id]
    user = User.where(token: params[:id]).first
    redirect_to expired_token_path unless user
  end

  def expired
  end

  def create
  end


end
