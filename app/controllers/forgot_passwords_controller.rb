class ForgotPasswordsController < ApplicationController
  def create
    user = User.find_by(email_address: params[:email])
    if user
      AppMailer.delay.send_forgot_password(user)
      redirect_to forgot_password_confirmation_path
    else
      flash[:error] = params[:email].blank? ? "Email cannot be blank." : "Email address not in system"
      redirect_to forgot_password_path
    end
  end
end