class InviteMailer < ApplicationMailer
  default from: 'no-reply@birs.ca'

  def invite_email
    @invite = params[:invite]
    @proposal = @invite.proposal
    @person = @invite.person

    mail(to: @person.email, subject: 'Invitation as a')
  end
end
