class Api::SessionsController < Api::BaseController
  before_action :get_token

  def create
    if @token.payload[:pin] == params[:pin]
      params = { verified: true }
      if @token.payload[:user_id].nil?
        user = User.create phone: @token.payload[:phone]
        params[:user_id] = user.id
      end
      @token.set params
    else
      render json: @token, status: :unprocessable_entity
    end
  end
end