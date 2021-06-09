class FeedbacksController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @feedback = Feedback.all
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.user = current_user
    if @feedback.save
      redirect_to dashboards_path
    else
      render :new, alert: 'There is error while saving feedback'
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:content)
  end
end
