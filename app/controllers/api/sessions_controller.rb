class Api::SessionsController < ApplicationController
  before_action :set_token

  def create
    if @token.verified
      render json: @token 
    elsif @token.pin == params[:pin]
      @token.verified = true
      render json: @token
    else
      render json: @token, status: :unprocessable_entity
    end
  end

  def destroy
    @example.destroy
    render json: :ok
  end

  private

  def set_token
    @token = Token.new token: params[:token]
  end
end