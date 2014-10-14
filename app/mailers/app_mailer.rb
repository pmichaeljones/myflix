class AppMailer < ActionMailer::Base
  default from: 'info@myflix.com'

  def welcome_email(user)
    @user = user
    mail to: user.email_address, subject:"Welcome to MyFlix"
  end

  def forgot_password(user)
    @user = user
    mail to: user.email_address, subject:"Forgot Password Email for MyFlixx"
  end

  def send_invitation_email(invitation)
    @invitation = invitation
    mail to: invitation.recipient_email, subject: "Come Join MyFlix!"
  end


end
