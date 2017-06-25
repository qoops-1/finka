class Api::ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show]
  before_action :parse_conv_with_participants, only: [:create]
  
  def show 
    render json: @convrs
  end

  def create
    conv = Conversation.new conversation_params
    if conv.save
      render json: conv
    else
      render json: { errors: conv.errors.full_messages, status: :unprocessable_entity }
    end
  end
  
  private

  def set_conversation
    @convrs = Conversation.find(params[:id]) if params[:id]
  end

  def conversation_params
    params.permit(:title, user_ids: [])
  end
end
