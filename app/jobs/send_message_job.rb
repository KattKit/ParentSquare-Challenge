class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message_id:, resend_time: nil)
    MessageService.send_message(message_id, resend_time)
  end
end