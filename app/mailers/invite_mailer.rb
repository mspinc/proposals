class InviteMailer < ApplicationMailer
  def invite_email
    @invite = params[:invite]
    @proposal = @invite.proposal
    @person = @invite.person

    mail(to: @person.email, subject: "Invite for #{@invite.invited_as.titleize}")
  end

  def invite_acceptance
    @invite = params[:invite]
    @proposal = @invite.proposal
    @person = @invite.person

    mail(to: @person.email, subject: 'Invite Accepted')
  end

  def invite_decline
    @invite = params[:invite]
    @proposal = @invite.proposal
    @person = @invite.person

    mail(to: @person.email, subject: 'Invite Declined')
  end
end
