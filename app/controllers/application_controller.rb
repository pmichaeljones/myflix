class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "Login Required"
      redirect_to :root
    end

  end



end
