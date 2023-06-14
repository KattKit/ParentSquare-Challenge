module Api
  class AdminController < ApiController
    # TODO: setup serialization to control fields
    def show
      render json: Admin.find_by!(username: params[:id])
    end
  end
end
