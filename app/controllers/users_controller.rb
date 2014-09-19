class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    binding.pry

    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You're all signed up!"
      redirect_to :root
    else
      flash[:notice] = "Something went wrong."
      render :back
    end

  end

  def update

  end

  def destroy
  end


  private

  def user_params
    params.require(:user).permit(:email_address, :full_name, :password)
  end



end
