require 'rails_helper'

RSpec.describe "/proposal_forms", type: :request do
  let(:proposal_form) { create(:proposal_form, status: 'draft') }

  describe "GET /new" do
    before do
      get new_proposal_form_url
    end
    it { expect(response).to have_http_status(:ok) }
  end

  describe "GET /edit" do
    it "render a successful response" do
      get edit_proposal_form_url(proposal_form)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /update" do
    before do
      patch proposal_form_url(proposal_form)
    end
    it "updates the status to active" do
      expect(proposal_form.reload.status).to eq('active')
    end
  end
end
