class MessagesController < ApplicationController
  def create
    @application = Application.find(params[:application_id])
    @message = Message.new(message_params)
    @message.application = @application
    @message.sender = current_user
    if @application.user == current_user
      @message.receiver = @application.pet.user
    else
      @message.receiver = @application.user
    end
    if @message.save
      ApplicationChannel.broadcast_to(
        @application,
        render_to_string(partial: "message", locals: {message: @message})
      )
      head :ok
    else
      render "applications/show", status: :unprocessable_entity
    end
  end



  private

  def message_params
    params.require(:message).permit(:content)
  end


end
