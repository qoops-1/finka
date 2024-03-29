class Api::RegistrationsController < Api::BaseController
  before_action :find_user, only: [:create, :update, :destroy]

  def create
    payload = { phone: @phone }
    payload[:user_id] = @user.id unless @user.nil?
    @token = Token.new payload
  end

  private

  def find_user
    @phone = begin
      Utils.format_phone(params[:phone])
    rescue
     # render_errors("Не правильный номер", :unprocessable_entity)
     params[:phone]
    end
    @user = User.find_by(phone: @phone)
  end

  def user_params
    params.permit(:phone, :name)
  end
end
