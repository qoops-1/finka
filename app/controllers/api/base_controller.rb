class Api::BaseController < ApplicationController
  rescue_from SecurityError, with: :authentication_error
  
  protected

  def authenticate_user!
    get_token
    unless @token.payload[:verified]
      raise SecurityError.new 'Token is not verified'
    end
    @user = User.find @token.payload[:user_id]
  end

  def get_token
    # we accept Authorization=Bearer token
    p auth_values = request.headers["Authorization"]&.split(" ")
    @token = if !auth_values.nil? && auth_values[0] == "Bearer"
      begin
        Token.new auth_values[1]
      rescue
        raise SecurityError.new 'Incorrect token provided'
      end
    else
      raise SecurityError.new 'No Token'
    end
  end

  def render_errors(object, status)
    if object.is_a? String
      render json: { errors: object }, status: status
    else
      render json: { errors: object.errors.full_messages }, status: status
    end
  end

  def authentication_error(error)
    render json: { errors: error }, status: :unauthorized
  end
end
