class Api::RegistrationsController < Api::BaseController
  before_action :find_user, only: [:create, :update, :destroy]

  def create
    payload = if @user.nil?
      { phone: params[:phone] }
    else
      { user_id: @user.id }
    end
    @token = Token.new payload
  end

  private

  def find_user
    @user = User.find_by(phone: params[:phone])
  end

  def user_params
    params.permit(:phone, :name)
  end
end