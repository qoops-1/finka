class Api::TransactionsController < Api::BaseController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:index, :create]
  
  after_action :send_messages, only: :create

  def index
    @transactions = @conversation.transactions
  end

  def show
    @transaction = Transaction.find params[:id]
  end

  def create
    @transaction = @conversation.transactions.new transaction_params
    @transaction.user = @user
    render_errors(@transaction, :unprocessable_entity) unless @transaction.save
  end

  private

  def set_conversation
    @conversation = Conversation.find params[:conversation_id]
  end

  def transaction_params
    params.permit(:ammount, :kind, :receiver_id, :comment)
  end

  def send_messages
    receiver = User.find(params[:receiver_id])
    transaction = @transaction.to_json
    phone = receiver.phone.sub
    Pusher.trigger("private-#{phone}", 'new-transaction', {
      transaction: transaction
    })
    puts "PUSHER: sent to: #{phone} transaction: #{transaction}}"
  end
end
