class SessionsController < ApplicationController


  def new
    redirect_to root_path if current_user

  end

  def create

   #binding.pry

    user = User.where(email_address: params[:email]).first

    #binding.pry

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:info] = "You are now logged in."
      redirect_to videos_path
    else
      flash[:danger] = "Your username or password was wrong."
      render :new
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end


  private

  def user_params

  end



end
