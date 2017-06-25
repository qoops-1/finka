class Api::BaseController < ApplicationController

  protected

  def current_user
    authenticate_user!
    @user
  end

  def authenticate_user!
    get_token
    if !@token
      render json: { errors: "No token in request", status: :unauthorized }
    elsif !@token.payload[:verified]
      render json: { errors: "Token not verified", status: :unauthorized }
    end
    @user = User.find @token.payload[:user_id]
  end

  def get_token
    # we accept Authorization=Bearer token
    auth_values = request.headers["Authorization"].split(" ")
    if auth_values[0] == "Bearer"
      @token = Token.new auth_values[1]
    else
      @token = nil
    end
  end
end
