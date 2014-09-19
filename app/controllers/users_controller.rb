class UsersController < ApplicationController

  # before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    #binding.pry

    @user = User.new(user_params)

    if @user.save
      flash[:info] = "You're all signed up!"
      redirect_to sign_in_path
    else
      render :new
    end

  end

  def update

  end

  def destroy
  end


  private

  def require_same_user
    @user = User.find_by slug: params[:id]

    if current_user != @user
      flash[:danger] = "You must be logged in."
      redirect_to :root
    end

  end


  def user_params
    params.require(:user).permit(:email_address, :full_name, :password)
  end



end
