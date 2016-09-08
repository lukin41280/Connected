class ConversationsController < ApplicationController
  # before_action :authenticate_user

  def index
    @user = User.find(1)
    conversation_hash = {conversations: []}
    @conversations = Conversation.where(sender_id: @user)
    @conversations.each do |conversation|
      conversation_hash[:conversations] << conversation.recipient
    end
    p conversation_hash
    render json: conversation_hash
  end

  def show
  end

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
