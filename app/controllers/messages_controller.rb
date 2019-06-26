class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      flash[:success] = "El mensaje se ha enviado con éxito."
    else
      flash[:warning] = "No se ha podido enviar el mensaje."
    end
    redirect_to conversation_messages_path(@conversation) if @message.save
  end

  private

  def message_params
    params.require(:message).permit(:subject, :body, :conversation_id, :user_id)
  end

end
