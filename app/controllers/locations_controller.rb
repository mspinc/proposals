class LocationsController < ApplicationController
  before_action :set_location

  def proposal_types
    render json: @location.proposal_types
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end
end
