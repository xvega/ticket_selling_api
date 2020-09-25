class ApplicationController < ActionController::API

  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Response
  include ExceptionHandler

  respond_to :json

  private

  def authenticate!
    authenticate_or_request_with_http_token do |token, _|
      @auth = ApiKey.exists?(access_token: token)
    end
  end
end
