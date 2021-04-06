class SubmitProposalsController < ApplicationController
  def new
    @location = Location.new
  end
end
