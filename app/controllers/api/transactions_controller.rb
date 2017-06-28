class Api::TransactionsController < Api::BaseController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:index, :create]

  def index
    @transactions = @conversation.transactions
  end

  def show
    @transaction = Transaction.find params[:id]
  end

  def create
    @transaction = @conversation.transactions.new transaction_params
    @transaction.user = @user
    render_errors(@transaction, :unprocessable_entity) unless transaction.save
    send_messages
  end

  private

  def set_conversation
    @conversation = Conversation.find params[:conversation_id]
  end

  def transaction_params
    params.permit(:ammount, :type, :receiver_id, :comment)
  end

  def send_messages
    receiver = User.find(params[:receiver_id])
    transaction = @transaction.to_json
    Pusher.trigger("private-#{@user.phone}", 'new-transaction', {
      transaction: transaction.to_json
    })

    Pusher.trigger("private-#{receiver.phone}", 'new-transaction', {
      transaction: transaction.to_json
    })
  end
end
