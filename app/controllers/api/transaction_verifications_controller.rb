class Api::TransactionVerificationsController < Api::BaseController
  before_action :authenticate_user!

  def create
    @transaction = Transaction.find(params[:id])
    status = params.permit(:status)
    @transaction.update_attributes verified: status
  end
end
