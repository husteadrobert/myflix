class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    #Validates, or
    flash[:danger] = "Correct the problems below"
    render 'new'
  end

end