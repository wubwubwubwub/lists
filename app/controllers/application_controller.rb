class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  
  before_filter :save_login_state, :only => [:create, :new]
  
  
  private
  
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
      #true
    else
      redirect_to log_in_path
      #false
    end
  end
  
  def save_login_state # prevents logged in user from accessing login page again
    if session[:user_id]
      redirect_to lists_path
    end
  end
      
  
end
