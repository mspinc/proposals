require 'rails_helper'

RSpec.describe "/locations", type: :request do
  let(:location) { create(:location) }

  describe "GET /index" do
    before do
      get locations_url
    end
    it { expect(response).to have_http_status(:ok) }
  end

  describe "GET /show" do
    before do
      get location_url(location)
    end
    it { expect(response).to have_http_status(:ok) }
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_location_url
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      get edit_location_url(location)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:location_params) { { name: 'Canada', code: 'CA', city: 'Vancouver', country: 'North America' } }
      it "creates a new Location" do
        expect do
          post locations_url, params: { location: location_params }
        end.to change(Location, :count).by(1)
      end
    end

    context "with invalid parameters" do
      let(:location_params) { { name: 'Canada', code: '', city: '', country: 'North America' } }

      it "does not create a new Location" do
        expect do
          post locations_url, params: { location: location_params }
        end.to change(Location, :count).by(0)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:location_params) { { name: 'Canada', code: 'CA', city: 'Vancouver', country: 'North America' } }

      before do
        patch location_url(location), params: { location: location_params }
      end
      it "updates the requested Location" do
        expect(location.reload.name).to eq('Canada')
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      delete location_url(location.id)
    end
    it { expect(Location.all.count).to eq(0) }
  end
end