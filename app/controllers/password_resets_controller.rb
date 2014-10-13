class PasswordResetsController < ApplicationController

  def show
    user = User.where(token: params[:id]).first

    if user
      @token = params[:id]
    else
      redirect_to expired_token_path
    end

  end

  def expired
  end

  def create
    user = User.where(token: params[:token]).first
      if user
      user.password = params[:password]
      user.generate_token
      user.save
      flash[:info] = "Password Changed."
      redirect_to sign_in_path
    else
      redirect_to expired_token_path
    end

  end


end
