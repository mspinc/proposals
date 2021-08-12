require 'rails_helper'

RSpec.describe "/people", type: :request do
  let(:person) { create(:person) }
  let(:proposal_type) { create(:proposal_type) }
  let(:proposal) { create(:proposal, proposal_type: proposal_type) }
  let(:invite) { create(:invite, proposal: proposal, person: person) }
  before do
    authenticate_for_controllers
  end
  describe "GET /new" do
    it "renders people object" do
      get new_person_url, params: { code: invite.code }
      expect(response).to have_http_status(:ok)
    end
  end
  describe "PATCH /update" do
    let(:person_params) do
      { city: 'California', affiliation: 'ABC', academic_status: 'Masters', first_phd_year: '2021', country: 'USA' }
    end
    context "with valid parameters" do
      before do
        patch person_url(person), params: { person: person_params, code: invite.code }
      end
      it "updates the requested Person" do
        expect(response).to redirect_to(new_survey_path(code: invite.code))
      end
    end
    context "with invalid parameters" do
      before do
        params = person_params.merge(city: '', code: invite.code)
        patch person_url(person), params: { person: params }
      end
      it "does not update Person" do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
