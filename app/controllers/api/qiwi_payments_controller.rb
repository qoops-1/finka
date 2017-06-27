class Api::QiwiPaymentsController < Api::BaseController
  before_action :authenticate_user!

  def create
    receiver = params[:phone]
    sender = @user.phone
    ammount = params[:ammount]
    access_token = get_token.payload[:qiwi_access_token]
    @response = Qiwi.pay(sender, receiver, ammount, access_token)
  end
end
