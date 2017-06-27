class Api::RegistrationsController < Api::BaseController
  before_action :find_user, only: [:create, :update, :destroy]

  def create
    @user = User.create user_params unless @user
    @token = Token.new user_id: @user.id
  end

  private

  def find_user
    @user = User.find_by(phone: params[:phone])
  end

  def user_params
    params.permit(:phone, :name)
  end
end