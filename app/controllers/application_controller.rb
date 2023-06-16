class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception

  def cors_preflight_check
    if request.method == 'OPTIONS'
      cors_set_access_control_headers
      render plain: '', content_type: 'text/plain', layout: false
    end
  end

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

  def cors_set_access_control_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email, X-User-Token, X-User-Email'
    response.headers['Access-Control-Max-Age'] = '1728000'
  end

end
