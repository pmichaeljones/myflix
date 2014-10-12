class AppMailer < ActionMailer::Base
  default from: 'pmichaeljones@gmail.com'

  def welcome_email(user)
    @user = user
    mail(to: user.email_address, subject:"Welcome to MyFlix").deliver
  end

end
