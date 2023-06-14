class WebhookController < Api::ApiController

  def index
    params.permit(:status, :message_id).to_h => {status:, message_id: remote_id}
    MessageService.update_message(status:, remote_id:)
    render :no_content
  end
end
