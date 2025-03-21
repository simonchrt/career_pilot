require 'rails_helper'

RSpec.describe "Applications", type: :request do
  let(:user) { create(:user) }
  let(:company) { create(:company) }
  let(:job_listing) { create(:job_listing, company: company) }
  let!(:application) { create(:application, user: user, job_listing: job_listing) }

  before do
    sign_in user
  end

  describe "GET /applications" do
    it "returns http success" do
      get applications_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /applications/:id" do
    it "returns http success" do
      get application_path(application)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /job_listings/:job_listing_id/apply" do
    it "returns http success" do
      get new_job_application_path(job_listing)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /applications" do
    let(:valid_params) do
      {
        application: {
          job_listing_id: job_listing.id,
          status: "applied",
          applied_date: Date.today,
          notes: "Test application",
          priority: 3
        }
      }
    end

    it "creates a new application and redirects" do
      expect {
        post applications_path, params: valid_params
      }.to change(Application, :count).by(1)

      expect(response).to redirect_to(application_path(Application.last))
    end
  end

  describe "GET /applications/:id/edit" do
    it "returns http success" do
      get edit_application_path(application)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /applications/:id" do
    let(:update_params) do
      {
        application: {
          status: "interviewing",
          notes: "Updated notes"
        }
      }
    end

    it "updates the application and redirects" do
      patch application_path(application), params: update_params

      application.reload
      expect(application.status).to eq("interviewing")
      expect(application.notes).to eq("Updated notes")
      expect(response).to redirect_to(application_path(application))
    end
  end

  describe "DELETE /applications/:id" do
    it "deletes the application and redirects" do
      expect {
        delete application_path(application)
      }.to change(Application, :count).by(-1)

      expect(response).to redirect_to(applications_path)
    end
  end
end
