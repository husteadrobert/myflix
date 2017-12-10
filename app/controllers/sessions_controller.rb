class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email_address: params[:email_address])
    binding.pry
    if user && user.authenticate(params[:password])
      #session[:user_id] = user.id
      redirect_to home_path
    else
      flash[:danger] = "Username or Password are incorrect."
      redirect_to login_path
    end
  end
end
