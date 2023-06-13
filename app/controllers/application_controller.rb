class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  
  protected

	def authenticate_eventos
		authenticate_or_request_with_http_basic do |username, password|
      username_password = Rails.application.secrets.eventos[username.to_sym]
      
      if username_password.present? && username_password[:password].to_s == password
          @usuario = username
          return true
      else
        raise ActionController::RoutingError, 'Not Found'
      end
		end
	end

end
