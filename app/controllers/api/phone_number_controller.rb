module Api
  class Api::PhoneNumberController < ApiController
    def index
      # TODO: phone number list
    end

    def show
      # TODO: find by phone number
      render json: PhoneNumber.find!(params[id])
    end
  end
end
