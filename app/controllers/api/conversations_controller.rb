class Api::ConversationsController < ApplicationController
  before_action :parse_convrs, only: [:show]
  before_action :parse_conv_with_participants, only: [:create]
  
  def show 
    render json: {"conversation": @convrs, "participants": @convrs.participants}
  end

  def create
    conv = Conversation.create(params[:conversation][:title])
    params[:users].each do |id|
      if User.find(id)
        Participant.create(conversation: conv.id, user: id)
      end
    end
  end
  
  private

  def parse_convrs
    if params[:id]
      @convrs = Conversation.find(params[:id]) 
    end
  end

  def parse_conv_with_participants
    params.require(:title)
    params.require(:users)
  end
end
