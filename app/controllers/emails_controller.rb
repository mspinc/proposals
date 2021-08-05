class EmailsController < ApplicationController
  def new
    @email = Email.new
  end
end
