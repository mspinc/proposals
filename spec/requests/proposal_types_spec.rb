require 'rails_helper'

RSpec.describe "/proposal_types", type: :request do
  let(:proposal_type) { create(:proposal_type) }

  describe "GET /index" do
    before do
      get proposal_types_url
    end
    it { expect(response).to have_http_status(:ok) }
  end

  describe "GET /show" do
    before do
      get proposal_type_url(proposal_type)
    end
    it { expect(response).to have_http_status(:ok) }
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_proposal_type_url
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      get edit_proposal_type_url(proposal_type)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:proposal_type_params) { { name: '2 Day Workshop' } }
      it "creates a new proposal_type" do
        expect do
          post proposal_types_url, params: { proposal_type: proposal_type_params }
        end.to change(ProposalType, :count).by(1)
      end
    end

    context "with invalid parameters" do
      let(:proposal_type_params) { { name: ' ' } }

      it "does not create a new proposal_type" do
        expect do
          post proposal_types_url, params: { proposal_type: proposal_type_params }
        end.to change(ProposalType, :count).by(0)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:proposal_type_params) { { name: '5 Day Workshop' } }

      before do
        patch proposal_type_url(proposal_type), params: { proposal_type: proposal_type_params }
      end
      it "updates the requested proposal_type" do
        expect(proposal_type.reload.name).to eq('5 Day Workshop')
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      delete proposal_type_url(proposal_type.id)
    end
    it { expect(ProposalType.all.count).to eq(0) }
  end
end
