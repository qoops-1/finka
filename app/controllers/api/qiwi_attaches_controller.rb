class Api::QiwiAttachesController < Api::BaseController
  before_action :authenticate_user!

  def create
    pin = params[:pin]
    @token = get_token
    code = @token.payload[:qiwi_code]
    p "+++++++++++++++++++"
    p qiwi_access_token = Qiwi.get_token(pin, code)
    p "+++++++++++++++++++"
    @token.set qiwi_access_token: qiwi_access_token
  end

  def show
    @token = get_token
    qiwi_code = Qiwi.get_code @user.phone
    @token.set qiwi_code: qiwi_code
  end
end
