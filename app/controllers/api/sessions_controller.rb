class Api::SessionsController < ApplicationController
  before_action :set_token

  def create
    if @token.payload[:verified]
      render json: @token 
    elsif @token.payload[:pin] == params[:pin]
      @token.set verified: true
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
    @token = Token.new params[:token]
  end
end