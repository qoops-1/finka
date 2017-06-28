class Api::PusherAuthsController < Api::BaseController
  before_action :get_token

  def create
    if !@token || !@token.payload[:verified]
      render json: 'Forbidden', status: :forbidden
    else
      render json: Pusher.authenticate(params[:channel_name], params[:socket_id])
    end
  end
end
