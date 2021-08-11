require 'rails_helper'

RSpec.describe "/page_content", type: :request do
  let(:page_content) { create(:page_content) }

  before do
    authenticate_for_controllers
  end

  describe "PATCH /update" do
    let(:page_content_params) do
      { guideline: 'This is a new guideline' }
    end

    context "with valid parameters" do
      before do
        patch page_content_url(page_content), params: { page_content: page_content_params }
      end

      it "updates the requested Page content" do
        expect(page_content.reload.guideline).to eq('This is a new guideline')
        expect(response).to redirect_to(guidelines_url)
      end
    end

    context "with invalid parameters" do
      before do
        params = page_content_params.merge(guideline: '')
        patch page_content_url(page_content), params: { page_content: params }
      end

      it "does not update Location" do
        expect(response).to redirect_to(guidelines_url)
      end
    end
  end
end