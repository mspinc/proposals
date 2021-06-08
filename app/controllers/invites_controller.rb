class InvitesController < ApplicationController
  before_action :authenticate_user!, except: %i[show inviter_response]
  before_action :set_proposal, only: %i[new create index show]
  before_action :set_invite, only: %i[show inviter_response]

  def index
    @invites = @proposal.invites
  end

  def show
    redirect_to root_path and return if @invite.completed?

    render layout: 'devise'
  end

  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.proposal = @proposal
    person unless @invite.person

    if @invite.save
      InviteMailer.with(invite: @invite).invite_email.deliver_later
      redirect_to edit_proposal_path(@proposal)
    else
      render :new, alert: 'Error sending invite'
    end
  end

  def inviter_response
    @invite.update(response: params[:response], status: 'completed')
    proposal_role unless @invite.no?
    user unless @invite.person.user

    if @invite.no?
      InviteMailer.with(invite: @invite).invite_decline.deliver_later
      redirect_to thanks_proposal_invites_path(@invite.proposal)
    else
      InviteMailer.with(invite: @invite).invite_acceptance.deliver_later
      redirect_to new_survey_path(code: @invite.code)
    end
  end

  def thanks
    render layout: 'devise'
  end

  private

  def person
    @invite.person = Person.find_or_create_by!(firstname: @invite.firstname, lastname: @invite.lastname, email: @invite.email)
  end

  def user
    user = User.new(email: @invite.person.email, password: '123456123456')
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
    params.require(:invite).permit(:firstname, :lastname, :email, :invited_as)
  end

  def proposal_role
    role = Role.find_or_create_by!(name: @invite.invited_as)
    @invite.proposal.proposal_roles.create(role: role, person: @invite.person)
  end
end
