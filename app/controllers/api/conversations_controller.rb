class Api::ConversationsController < ApplicationController
    before_action :parse_convrs, only: [:show]
    before_action :parse_conv_with_participants, only: [:create]
    
    def show 
      render json: @convrs
    end

    def create
      params[:participants].each do |id|
        Participant.create(id)
      end
     Conversation.create(params[:conversation][:title])
    end
    
    private

    def parse_convrs
        @convrs = Conversation.find(params[:id]) if params[:id]
    end

    def parse_conv_with_participants
      params.require(:participants)
      params.require(:conversation).require(:title)
    end
end
