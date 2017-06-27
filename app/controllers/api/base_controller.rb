class Api::BaseController < ApplicationController
  
  protected

  def authenticate_user!
    get_token
    if !@token
      render_errors("No token in request", :unauthorized)
    elsif !@token.payload[:verified]
      render_errors("Token not verified", :unauthorized)
    end
    @user = User.find @token.payload[:user_id]
  end

  def get_token
    # we accept Authorization=Bearer token
    auth_values = request.headers["Authorization"]&.split(" ")
    if !auth_values.nil? && auth_values[0] == "Bearer"
      @token = Token.new auth_values[1]
    else
      @token = nil
    end
  end

  def render_errors(object, status)
    if object.is_a? String
      render json: { errors: object }, status: status
    else
      render json: { errors: object.errors.full_messages }, status: status
    end
  end
end
