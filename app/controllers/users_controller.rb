class UsersController < ApplicationController
  
  # before_action :permitted_user, only: [:show]
  
  def show
    # @user = User.find(params[:id])    
    # @user = User.find_by_username(params[:username])
    
    @user = params[:username] ? User.find_by_username(params[:username]) : User.find(params[:id])

    if @user && @user != current_user
      redirect_to root_path
    else
      @lists = @user.lists.all
      render "lists/index"
    end
  end
  
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
