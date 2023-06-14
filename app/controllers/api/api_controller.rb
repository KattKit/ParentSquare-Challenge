module Api
  class ApiController < ActionController::API
    rescue_from Exception, with: :render_error

    private
    def render_error(e)
      if e.class.name == "ActiveRecord::RecordNotFound"
        render json: { message: "Not found" }.to_json, status: 404
      else
        logger.error e.message
        e.backtrace.each { |line| logger.error line }
        render json: { message: "Internal server error" }.to_json, status: 500
      end
    end

    def authenticate_admin!
      authenticate_user_with_token || handle_bad_authentication
    end

    def authenticate_user_with_token
      authenticate_with_http_token do |token, type|
        @admin ||= Admin.find_by(api_key: token)
      end
    end

    def handle_bad_authentication
      render json: { message: "Bad credentials" }, status: :unauthorized
    end

    def authenticate_with_http_token
      yield *request.headers["Authorization"]&.split(" ")&.reverse || [nil, nil]
    end
  end
end
