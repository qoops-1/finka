class Api::RegistrationsController < Api::BaseController
  before_action :find_user, only: [:create, :update, :destroy]

  def create
    @user = User.create user_params unless @user
    token = Token.new user_id: @user.id
    render json: token
  end

  def destroy
    @example.destroy
    render json: :ok
  end

  private

  def find_user
    @user = User.find_by(phone: params[:phone])
  end

  def user_params
    params.permit(:phone, :name)
  end
end