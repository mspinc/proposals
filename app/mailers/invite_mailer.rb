class InviteMailer < ApplicationMailer
  default from: 'no-reply@birs.ca'

  def invite_email
    @invite = params[:invite]
    @proposal = @invite.proposal
    @person = @invite.person

    mail(to: @person.email, subject: 'Invitation as a')
  end

  def invite_acceptance
    @invite = params[:invite]
    @proposal = @invite.proposal
    @person = @invite.person

    mail(to: @person.email, subject: 'Acceptance Response')
  end

  def invite_decline
    @invite = params[:invite]
    @proposal = @invite.proposal
    @person = @invite.person

    mail(to: @person.email, subject: 'Decline Response')
  end
end
