class FeedbackMailer < ApplicationMailer
  def new_feedback_email
    @feedback = params[:feedback]
    email = "birs@birs.ca"
    mail(to: email, subject: "You got a new feedback!")
  end
end
