class AppMailer < ActionMailer::Base
  default from: 'info@myflix.com'

  def welcome_email(user)
    @user = user
    mail to: user.email_address, subject:"Welcome to MyFlix"
  end

end