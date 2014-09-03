class SessionsController < ApplicationController
    before_filter :save_login_state, :only => [:create, :new]

  def new
    render layout: false
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to lists_path, notice: "Welcome #{params[:username]}!"
    else
      flash.now.alert = "Invalid email or password"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

end
