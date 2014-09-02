class UsersController < ApplicationController
  def new
    @user = User.new
    render layout: false
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You signed up successfully, please log in"
      # flash[:color]= "valid"
      render 'sessions/new', layout: false
    else
      flash[:notice] = "Form is invalid"
      # flash[:color]= "invalid"
      render 'new', layout: false
    end

  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
