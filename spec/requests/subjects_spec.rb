require 'rails_helper'

RSpec.describe "/subjects", type: :request do
  let(:subject_category) { create(:subject_category) }
  let(:subject) { create(:subject, subject_category: subject_category) }

  describe "GET /new" do
    before do
      get new_subject_category_subject_url(subject_category)
    end
    it { expect(response).to have_http_status(:ok) }
  end

  describe "POST /create" do
    let(:subject_category) { create(:subject_category) }
    let(:subject_params) do
        { code: '02-XX',
          title: 'Subject',
          subject_category_id: subject_category.id }
    end

    context "with valid parameters" do
      it "creates a new Subject" do
        expect do
          post subject_category_subjects_url(subject_category), params: { subject: subject_params }
        end.to change(Subject, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Subject" do
        expect do
          get new_subject_category_subject_url(subject_category), params: { subject: subject_params }
        end.to change(Subject, :count).by(0)
      end
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      get edit_subject_category_subject_url(subject_category, subject)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:params) { { subject: { title: 'category' } } }
      before do
        patch subject_category_subject_url(subject_category, subject, params: params)
      end

      it "updates the title to category" do
        expect(subject.reload.title).to eq('category')
      end
    end

    context "with invalid parameters" do
      let(:params) { { subject: { title: 'category' } } }
      before do
        patch subject_category_subject_url(subject_category, subject, params: params)
      end

      it "will not update subject" do
        expect(subject.reload.title).to eq(subject.title)
      end
    end
  end

  describe "DELETE /subject" do
    before do
      delete subject_category_subject_url(subject_category.id, subject.id)
    end
    it { expect(Subject.all.count).to eq(0) }
  end
end
