class Message < ApplicationRecord
  belongs_to :application
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"


  # def message_count
  #   @messages == Message.where(receiver_id: current_user)
  #   @rescue = User.select do |user|
  #     rescue_email = user.email.split("@")[1]
  #     user.domain != nil && user.domain.include?(rescue_email)
  #       # return true
  #   end
  #   if @rescue == []
  #     @messages = current_user.messages(reciver_id: current_user)
  #   else
  #   @messages = @rescue.first.message + current_user.messages[reciver_id: current_user]
  #   end
  #   return @messages.count
  # end
end
