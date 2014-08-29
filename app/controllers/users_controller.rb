class UsersController < ApplicationController
  def new
    @user = User.new
    render layout: false
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, notice: "Signed up! Please log in.."
    else
      render 'new', layout: false
    end
    
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
