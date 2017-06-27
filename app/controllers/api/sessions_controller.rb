class Api::SessionsController < Api::BaseController
  before_action :get_token

  def create
    if @token.payload[:pin] == params[:pin]
      @token.set verified: true
    else
      render json: @token, status: :unprocessable_entity
    end
  end
end