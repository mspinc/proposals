class EmailsController < ApplicationController
  load_and_authorize_resource
  def new
    @email = Email.new
  end
end
