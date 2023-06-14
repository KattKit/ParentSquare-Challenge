class Api::EventController < Api::ApiController
  def index
    # TODO: pagination
    # TODO: filters
    render json: {
      events: ::EventBlueprint.render_as_hash(Event.all) || [],
      next: ""
    }
  end

  def show
    render json: ::EventBlueprint.render_as_hash(Event.find(params[:id]))
  end
end
