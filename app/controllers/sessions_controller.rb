class SessionsController < ApplicationController
  def new
  end

  def create
    #Validation code, else

    flash[:danger] = "Username or Password are incorrect."
    redirect_to login_path
  end
end
