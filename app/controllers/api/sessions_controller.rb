class Api::SessionsController < Api::BaseController
  before_action :get_token

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
end