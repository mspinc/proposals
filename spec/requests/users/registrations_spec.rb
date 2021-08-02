require 'rails_helper'

RSpec.describe ::Users::RegistrationsController, type: :request do
  describe "GET /new" do
    it "renders a successful response" do
      get new_user_registration_url
      expect(response).to have_http_status(:ok)
    end
  end
end
