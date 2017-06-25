class Api::UsersController < Api::BaseController
  before_action :authenticate_user!

  def show
    render json: current_user
  end  
end
