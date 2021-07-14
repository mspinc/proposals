class InvitesController < ApplicationController
  before_action :authenticate_user!, except: %i[show inviter_response thanks expired]
  skip_before_action :verify_authenticity_token, only: %i[create]
  before_action :set_proposal, only: %i[new create invite_reminder invite_email]
  before_action :set_invite, only: %i[show inviter_response cancel invite_reminder invite_email]
  before_action :set_invite_proposal, only: %i[show]

  def show
    redirect_to root_path and return if @invite.confirmed?
    redirect_to expired_path and return if @invite.cancelled?

    render layout: 'devise'
  end

  def invite_email
    if params[:id].eql?("0")
      inviters = Invite.where(proposal_id: @proposal.id, invited_as: params[:invited_as])
    else
      inviters = Invite.where(proposal_id: @proposal.id, invited_as: params[:invited_as]).where('id > ?', params[:id])
    end

    inviters.each do |invite|
      InviteMailer.with(invite: invite).invite_email.deliver_later
    end

    head :ok
  end

  def inviter_response
    @invite.update(response: response_params, status: 'confirmed')
    unless @invite.no?
      proposal_role
      if @invite.invited_as == 'Co Organizer'
        create_user unless @invite.person.user
      end
    end

    @co_organizers = @invite.proposal.list_of_co_organizers.remove(@invite.person&.fullname)

    if @invite.no?
      InviteMailer.with(invite: @invite).invite_decline.deliver_later
      redirect_to thanks_proposal_invites_path(@invite.proposal)
    else
      InviteMailer.with(invite: @invite, token: @token, co_organizers: @co_organizers).invite_acceptance
                  .deliver_later
      redirect_to new_person_path(code: @invite.code)
    end
  end

  def invite_reminder
    if @invite.pending?
      @co_organizers = @invite.proposal.list_of_co_organizers
      InviteMailer.with(invite: @invite, co_organizers: @co_organizers).invite_reminder.deliver_later
      redirect_to edit_proposal_path(@proposal), notice: "Invite reminder has been sent to #{@invite.person.fullname}!"
    else
      redirect_to edit_proposal_path(@proposal), notice: "You have already responded to the invite."
    end
  end

  def thanks
    render layout: 'devise'
  end

  def expired
    render layout: 'devise'
  end

  def cancel
    @invite.update(status: 'cancelled')
    redirect_to edit_proposal_path(@invite.proposal), notice: 'Invite has been cancelled!'
  end

  private

  def set_invite_proposal
    @proposal = Proposal.find_by(id: @invite.proposal)
  end

  def response_params
    params.require(:commit)&.downcase
  end

  def create_user
    user = User.new(email: @invite.person.email,
                    password: SecureRandom.urlsafe_base64(20))
    user.person = @invite.person
    user.save
  end

  def set_invite
    @invite = Invite.find_by(code: params[:code])
  end

  def set_proposal
    @proposal = Proposal.find(params[:proposal_id])
  end

  def invite_params
    params.require(:invite).permit(:firstname, :lastname, :email, :invited_as,
            :deadline_date)
  end

  def proposal_role
    role = Role.find_or_create_by!(name: @invite.invited_as)
    @invite.proposal.proposal_roles.create(role: role, person: @invite.person)
  end
end
