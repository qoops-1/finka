class Api::UsersController < Api::BaseController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def update
    current_user.update_attributes user_params
    @user = current_user
  end

  private

  def user_params
    params.permit(:name)
  end
end
