class Api::UsersController < Api::BaseController
  before_action :authenticate_user!

  def show
  end

  def update
    @user.update_attributes user_params
  end

  private

  def user_params
    params.permit(:name)
  end
end
