class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from Exception, with: :render_error
  before_action :javascript_configuration

  def index
    render template: 'application'
  end

  private
  def render_error(e)
    flash.now[:notice] = e.to_json
    render template: 'application'
  end
  def javascript_configuration
    @javascript_configuration = {
      baseUrl: root_url.to_s
    }.to_json.html_safe
  end
end
