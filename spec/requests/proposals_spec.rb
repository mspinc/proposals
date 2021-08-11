require 'rails_helper'

RSpec.describe "Proposals", type: :request do
  let(:user) { create(:user) }
  let(:person) { create(:person, :with_proposals, user: user) }
  let(:proposal) { person.proposals.first }
  let(:proposal_location) { create(:proposal_location, proposal: proposal) }

  before { authenticate_for_controllers(person) }

  describe "GET /index" do
    before do
      person
      get proposals_path
    end
    it { expect(response).to have_http_status(:ok) }
  end

  describe "GET /new" do
    before { get new_proposal_path }
    it { expect(response).to have_http_status(:ok) }
  end

  describe "POST /create" do
    let(:proposal_form) { create(:proposal_form, proposal_type: proposal.proposal_type, status: 'active') }
    before do
      proposal_form
      post proposals_path, params: params
    end

    context 'when already has proposal it will not create' do
      let(:params) do
        { proposal: { proposal_type_id: proposal.proposal_type.id, title: 'Test proposal', year: '2023' } }
      end

      it { expect(response).to redirect_to(new_proposal_path) }
    end

    context 'when does not have proposal it will create new' do
      let(:proposal_type) { create(:proposal_type) }
      let(:form) { create(:proposal_form, status: :active, proposal_type: proposal_type) }
      let(:params) do
        { proposal: { proposal_type_id: form.proposal_type.id, title: 'Test proposal', year: '2025' } }
      end

      it { expect(response).to redirect_to(edit_proposal_path(Proposal.last)) }
    end
  end

  describe "GET /show" do
    before { get proposal_path(proposal) }

    it { expect(response).to have_http_status(:ok) }
  end

  describe "GET /edit" do
    before { get edit_proposal_path(proposal) }

    it { expect(response).to have_http_status(:ok) }
  end

  describe "print latex" do
    it 'latex input' do
      post "/proposals/#{proposal.id}/latex"
      expect(response).to have_http_status(:ok)
    end

    it 'latex output' do
      get "/proposals/#{proposal.id}/rendered_proposal.pdf"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /destroy" do
    before do
      delete proposal_url(proposal)
    end

    it { expect(Proposal.all.count).to eq(2) }
  end

  describe "PATCH /ranking" do
    before { patch ranking_proposal_url(proposal), params: { location_id: proposal_location.location.id, position: 2 } }

    it "updates proposal locations" do
      expect(proposal_location.reload.position).to eq(2)
    end
  end
end
