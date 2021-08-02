require 'rails_helper'

RSpec.describe "/submitted_proposals", type: :request do
  let(:proposal_role) { create(:proposal_role) }

  before do
    authenticate_user
  end

  describe "GET /index" do
    before do
      get submitted_proposals_url
    end
    it { expect(response).to have_http_status(:ok) }
  end

  describe "GET /show" do
    before do
      proposal_role.role.update(name: "lead_organizer")
      get submitted_proposal_url(proposal_role.proposal)
    end

    it { expect(response).to have_http_status(:ok) }
  end
end
