class UsersController < ApplicationController
  before_filter :require_user, :only => [:show]

  def new_with_invitation_token
    invitation = Invitation.where(token: params[:token]).first
    if invitation
      @invitation_token = invitation.token
      @user = User.new(email_address: invitation.recipient_email)
      render :new
    else
      redirect_to expired_token_path
    end

  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    #binding.pry
    @user = User.new(user_params)

    if @user.save
      if params[:invitation_token].present?
        invitation = Invitation.where(token: params[:invitation_token]).first
        @user.follow(invitation.inviter)
      end
      AppMailer.welcome_email(@user).deliver
      flash[:info] = "You're all signed up!"
      redirect_to sign_in_path
    else
      render :new
    end

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
