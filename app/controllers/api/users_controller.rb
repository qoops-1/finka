class Api::UsersController < ApplicationController
  
  def show
    render json: User.find(params.require(:id))
  end
  
end
