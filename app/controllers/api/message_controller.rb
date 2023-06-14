module Api
  class Api::MessageController < ApiController

    def index
      # TODO: pagination
      # TODO: filters
      render json: {
        messages: ::MessageBlueprint.render_as_hash(Message.all) || [],
        next: ""
      }
    end

    def show
      render json: ::MessageBlueprint.render(Message.find(params[:id]))
    end

    def create
      params.permit(:to_number, :message).to_h => {to_number:, message:}
      result = MessageService.create_message(to_number, message)
      if result.success?
        render json: result.message_object
      else
        render json: { message: result.message }
      end
    end
  end
end
