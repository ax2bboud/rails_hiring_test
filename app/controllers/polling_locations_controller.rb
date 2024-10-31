class PollingLocationsController < ApplicationController
    before_action :set_riding
  
    # Custom action for updating all polling locations
    def update_all
      params[:polling_locations].each do |id, polling_location_params|
        polling_location = @riding.polling_locations.find_or_initialize_by(id: id)
        polling_location.update(polling_location_params.permit(:title, :address, :city, :postal_code))
  
        if polling_location_params[:polls]
          polling_location_params[:polls].each do |poll_id, poll_params|
            poll = Poll.find_or_initialize_by(id: poll_id)
            poll.update(poll_params.permit(:number))
          end
        end
      end
  
      redirect_to riding_path(@riding), notice: "Polling locations updated successfully."
    end
  
    private
  
    def set_riding
      @riding = Riding.find(params[:riding_id])
    end
end
  