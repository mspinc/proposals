require 'rails_helper'

RSpec.describe "/proposals/:proposal_id/invites", type: :request do
  let(:proposal_type) { create(:proposal_type) }
  let(:proposal) { create(:proposal, proposal_type: proposal_type) }
  let(:invite) { create(:invite, proposal: proposal) }

  describe "GET /new" do
    before do
      authenticate_for_controllers
      get new_proposal_invite_path(proposal_id: invite.proposal.id)
    end

    it "renders a successful response" do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    before do
      authenticate_for_controllers
    end
    context "with valid parameters" do
      let(:params) do
        { firstname: 'Ben',
          lastname: 'Tan',
          email: 'ben@tan.com',
          invited_as: 'Participant',
          deadline_date: Time.current.to_date }
      end
      it "creates a new invite" do
        expect do
          post proposal_invites_url(proposal_id: proposal.id), params: { invite: params }
        end.to change(Invite, :count).by(1)
      end
    end

    context "with invalid parameters" do
      before do
        proposal.proposal_type.update(participant: 0)
      end
      let(:params) do
        { firstname: 'Handree',
          lastname: 'Tan',
          email: 'ben@tan.com',
          invited_as: 'Participant' }
      end
      it "does not create a new invite" do
        expect do
          post proposal_invites_url(proposal_id: proposal.id), params: { invite: params }
        end.to change(Invite, :count).by(0)
      end
    end
  end

  describe "POST /inviter_response" do
    before do
      post inviter_response_proposal_invite_path(proposal_id: proposal.id, id: invite.id, code: invite.code, commit: commit)
    end

    context 'when response is yes/maybe' do
      let(:commit) { 'YES' }
      it { expect(invite.proposal.proposal_roles.last.role.name).to eq(invite.invited_as) }
      it { expect(response).to redirect_to(new_person_path(code: invite.code)) }
    end

    context 'when response is no' do
      let(:commit) { 'No' }
      it { expect(response).to have_http_status(:found) }
    end
  end

  describe "GET /show" do
    before do
      get invite_path(code: invite1.code)
    end

    context 'when status is pending' do
      let(:invite1) { create(:invite, status: 'pending') }
      it { expect(response).to have_http_status(:ok) }
    end

    context 'when status is confirmed' do
      let(:invite1) { create(:invite, status: 'confirmed') }
      it { expect(response).to redirect_to(root_path) }
    end

    context 'when status is cancelled' do
      let(:invite1) { create(:invite, status: 'cancelled') }
      it { expect(response).to redirect_to(expired_path) }
    end
  end

  describe "GET /thanks" do
    it "render a successful response" do
      get thanks_proposal_invites_url(invite.proposal)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /expired" do
    it "render a message when an invite has been expired" do
      get expired_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /cancel" do
    let(:invite1) { create(:invite, status: 'cancelled') }
    before do
      authenticate_for_controllers
      post cancel_path(code: invite.code), params: { invite: invite1 }
    end
    
    it "updates the invite status" do
      expect(invite1.reload.status).to eq('cancelled')
      expect(response).to redirect_to(edit_proposal_path(invite.proposal))
    end
  end

  describe "POST /inviter_reminder" do
    before do
      authenticate_for_controllers
      post invite_reminder_proposal_invite_path(proposal_id: proposal.id, id: invite1.id, code: invite1.code)
    end

    context 'when status is pending' do
      let(:invite1) { create(:invite, status: 'pending') }
      it "sends invite reminder when invite status is pending" do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(edit_proposal_path(proposal.id))
      end
    end
    
    context 'when status is confirmed' do
      let(:invite1) { create(:invite, status: 'confirmed') }
      it "does not send invite reminder when invite status is pending" do
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(edit_proposal_path(proposal.id))
      end
    end
  end
end
