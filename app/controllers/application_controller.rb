class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :redirect_herokuapp


  helper_method :current_user

  private

  def redirect_herokuapp
    if request.host == 'texpaste.herokuapp.com'
      qs = request.query_string.present? ? '?' + request.query_string : ''
      redirect_to request.protocol + 'www.texpaste.com' + request.path + qs
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if (session[:user_id] && User.exists?(session[:user_id]))
    return @current_user

    if (@current_user) then
      return @current_user
    end
    if (session[:user_id] and User.exists(session[:user_id])) then
      @current_user = User.find(session[:user_id])
    else
      @current_user = User.new()
    end

  end

end
