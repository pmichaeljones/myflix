class ForgotPasswordsController < ApplicationController

  def create
    user = User.where(email_address: params[:email]).first

    if user
      AppMailer.forgot_password(user).deliver
      redirect_to forgot_password_confirmation_path
    elsif params[:email] == ""
      flash[:danger] = "E-mail cannot be blank."
      redirect_to forgot_password_path
    else
      flash[:danger] = "We do not have that email in our system."
      redirect_to forgot_password_path
    end

  end

end

