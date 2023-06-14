require "faraday"
require "json"

module Api
  class SmsProviderClient
    attr_reader :name

    def initialize(base_url:, callback_url:, name: "default")
      @base_url = base_url
      @callback_url = callback_url
      @name = name
      @conn = Faraday.new(@base_url) do |f|
        f.request :json
        f.response :json
        f.response :raise_error
      end
    end
    
    def send_message(phone_number, message_body)
      response = @conn.post("", {
        to_number: phone_number,
        message: message_body,
        callback_url: @callback_url
      })
      response.body["message_id"]
    end
  end
end