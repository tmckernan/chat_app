class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom

  def create
    @message = @chatroom.messages.build(message_params)
    @message.user = current_user

    if @message.save
      # No explicit redirect needed for Turbo Streams, it handles the update
      head :ok # Send a 200 OK response

    else
      # binding.pry
      # Re-render the form if validation fails within the Turbo Frame
      render turbo_stream: turbo_stream.replace("new_message", partial: "messages/form", locals: { message: @message, chatroom: @chatroom }), status: :unprocessable_entity
    end
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
