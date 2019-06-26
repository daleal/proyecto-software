class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.involving(current_user.id)
    # @users = User.where(["id <> :id", { id: current_user.id }])
    @users = User.all
  end

  def create
    matches = Conversation.between(params[:sender_id], params[:recipient_id])
    @conversation = if matches.present? then matches.first else Conversation.create!(conversation_params) end
    if @conversation.save
      flash[:success] = "La conversación se ha creado con éxito."
    else
      flash[:warning] = "No se ha podido crear la conversación."
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

end
