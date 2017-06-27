class Api::ConversationsController < Api::BaseController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show]

  def index
    render json: current_user.conversations
  end
  
  def show 
    render json: @conversations
  end

  def create
    conversation = current_user.conversations.new conversation_params
    if conversation.save
      render json: conversation
    else
      render json: { 
        errors: conversation.errors.full_messages, 
        status: :unprocessable_entity 
      }
    end
  end
  
  private

  def set_conversation
    @conversation = Conversation.find params[:id]
  end

  def conversation_params
    params.permit(:title, user_ids: [])
  end
end
