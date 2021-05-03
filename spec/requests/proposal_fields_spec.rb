require 'rails_helper'

RSpec.describe "/proposal_forms/:id/proposal_fields", type: :request do
  let(:proposal_form) { create(:proposal_form, status: 'draft') }

  describe "GET /new" do
    it "renders a successful response" do
      get new_proposal_form_proposal_field_path(proposal_form_id: proposal_form.id, field_type: 'Text')
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:params) { { statement: 'Radio Type Field', index: 0, description: 'some description' } }
      it "creates a new proposal field" do
        expect do
          post proposal_form_proposal_fields_url(proposal_form_id: proposal_form.id, type: 'Radio'),
               params: { proposal_field: params }
        end.to change(ProposalField, :count).by(1)
      end
    end
  end
end
