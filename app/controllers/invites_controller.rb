class InvitesController < ApplicationController
  before_action :set_proposal, only: %i[new create index]

  def index
    @invites = Invite.all
  end

  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(invite_params)
    @invite.proposal = @proposal
    @invite.create_person(firstname: @invite.firstname, lastname: @invite.lastname, email: @invite.email)

    if @invite.save
      redirect_to edit_proposal_path(@proposal)
    else
      render :new, error: 'Error sending invite'
    end
  end

  private

  def set_proposal
    @proposal = Proposal.find(params[:proposal_id])
  end

  def invite_params
    params.require(:invite).permit(:firstname, :lastname, :email, :invited_as)
  end
end
