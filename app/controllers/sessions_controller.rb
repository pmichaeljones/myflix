class SessionsController < ApplicationController


  def new

  end

  def create

   #binding.pry

    @user = User.where(email_address: params[:email]).first

    #binding.pry

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to videos_path
    else
      flash[:notice] = "Your username or password was wrong."
      redirect_to :back
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
