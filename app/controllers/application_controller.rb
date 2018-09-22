class ApplicationController < ActionController::Base


  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def isValid
     if !current_user
       redirect_to '/users/new', notice: "debes inicias sesion"
     end
  end

  helper_method :current_user
  helper_method :isValid

end
