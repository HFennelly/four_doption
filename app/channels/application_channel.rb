class ApplicationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    application = Application.find(params[:id])
    stream_for application
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
