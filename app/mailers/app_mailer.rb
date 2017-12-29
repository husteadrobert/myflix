class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail from: "info@myflix.com", to: user.email_address, subject: "Welcome to Myflix!"
  end

  def send_forgot_password(user)
    @user = user
    mail to: @user.email_address, from: "info@myflix.com", subject: "Please reset your password"
  end

  def send_invitation(invitation)
    @invitation = invitation
    mail to: invitation.recipient_email, from: "info@myflix.com", subject: "Your friend has invited you to join MyFlix!"
  end
end