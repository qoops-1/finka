class Api::ConversationsController < Api::BaseController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show]

  after_action :send_messages, only: :create

  def index
    @conversations = @user.conversations
  end
  
  def show
    unless @conversation.users.include? @user
      render_errors("You are not a member of this conversation", :unauthorized)
    end
  end

  def create
    @conversation = @user.conversations.new conversation_params
    render_errors(@conversation, :unprocessable_entity) unless @conversation.save
  end
  
  private

  def set_conversation
    @conversation = Conversation.find params[:id]
  end

  def conversation_params
    {
      user_ids: params[:user_phones].map { |phone| Utils.format_phone(phone) }
        .map { |phone| User.find_by(phone: phone) }
        &.pluck(:id)
        .concat([@user.id]),
      title: params[:title]
    }
  end

  def send_messages
    @conversation.users.each do |user|
      ChatsChannel.broadcast_to(user, build_message(user))
    end
  end

  def build_message(user)
    ActionController::Base.new.view_context.render(partial: "api/conversations/create",
     locals: {user: user, conversation: @conversation})
  end
end
