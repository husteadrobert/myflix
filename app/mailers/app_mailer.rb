class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail from: "info@myflix.com", to: user.email_address, subject: "Welcome to Myflix!"
  end
end