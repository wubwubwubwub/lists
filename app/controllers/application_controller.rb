class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user


  private 
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      redirect_to log_in_path
    end
  end
  def save_login_state
    if session[:user_id]
      redirect_to user_path(current_user)
    end
  end
  def permitted_list
    if List.find(params[:id]).user_id != current_user.id
      redirect_to user_path(current_user)
      flash[:notice] = "You can only access your own content"
    end
  end  
  def permitted_user
    if User.find(params[:id]) != current_user
      redirect_to user_path(current_user)
      flash[:notice] = "This is not your user"
    end
  end
end
