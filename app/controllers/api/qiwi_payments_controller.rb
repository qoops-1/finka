class Api::QiwiPaymentsController < Api::BaseController
  before_action :authenticate_user!

  def create
    receiver = params[:phone]
    sender = @user.phone
    ammount = params[:ammount]
    access_token = get_token.payload[:qiwi_access_token]
    p "++++++++++++++++"
    p @response = Qiwi.pay(sender, receiver, ammount, access_token)
    p "++++++++++++++++"
    
    if @response == "200"
      render json: { status: "accepted" }, status: :ok
    else
      render json: { status: "rejected" }, status: :bad_request
    end
  end
end
