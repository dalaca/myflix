class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :signed_in?, :require_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] 
  end

  def signed_in?
    !!current_user
  end

  def require_user
    unless signed_in?
      flash[:danger] = "You must be logged in to do this"
      redirect_to root_path
    end
  end
end
