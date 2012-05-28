class ApplicationController < ActionController::Base
  #protect_from_forgery

	helper_method :current_user

	private
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
