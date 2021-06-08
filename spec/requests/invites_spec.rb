require 'rails_helper'

RSpec.describe "/proposals/:proposal_id/invites", type: :request do
  let(:proposal) { create(:proposal) }
  let(:invite) { create(:invite) }

  describe "GET /index" do
    before do
      authenticate_for_controllers
      get proposal_invites_url(proposal_id: proposal.id)
    end
    it { expect(response).to have_http_status(:ok) }
  end

  describe "GET /new" do
    before do
      authenticate_for_controllers
      get new_proposal_invite_path(proposal_id: proposal.id)
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
      let(:params) do
        { firstname: 'Handree',
          lastname: 'Tan',
          email: 'ben@tan.com',
          invited_as: ' ' }
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
      post inviter_response_proposal_invite_path(proposal_id: proposal.id, id: invite.id, code: invite.code)
    end

    context 'when response is yes/maybe' do
      let(:params) { { response: 'yes' } }
      it { expect(invite.proposal.proposal_roles.last.role.name).to eq(invite.invited_as) }
      it { expect(response).to redirect_to(new_survey_path(code: invite.code)) }
    end

    context 'when response is no' do
      let(:params) { { response: 'no' } }
      it { expect(response).to have_http_status(:found) }
    end
  end

  describe "GET /show" do
    before do
      get proposal_invite_path(proposal_id: proposal.id, id: invite1.id, code: invite1.code)
    end

    context 'when status is pending' do
      let(:invite1) { create(:invite, status: 'pending') }
      it { expect(response).to have_http_status(:ok) }
    end

    context 'when status is completed' do
      let(:invite1) { create(:invite, status: 'completed') }
      it { expect(response).to redirect_to(root_path) }
    end
  end
end
