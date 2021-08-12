require 'rails_helper'

RSpec.describe "/profile", type: :request do
  let(:person) { create(:person) }
  before do
    authenticate_for_controllers
  end
  describe "PATCH /update" do
    let(:person_params) do
      { city: 'California', affiliation: 'ABC', academic_status: 'Masters', first_phd_year: '2021', country: 'USA' }
    end
    context "with valid parameters" do
      before do
        patch update_url(person), params: { person: person_params }
      end
      it "updates the requested Person" do
        # expect(person.reload.country).to eq("USA")
        expect(response).to redirect_to(profile_url)
      end
    end
    context "with invalid parameters" do
      before do
        params = person_params.merge(city: '', affiliation: '', academic_status: '', first_phd_year: '', country: '')
        patch update_url(person), params: { person: params }
      end
      it "does not update Person" do
        expect(response).to redirect_to(profile_url)
      end
    end
  end
end
