require 'rails_helper'

RSpec.describe "JobListings", type: :request do

  let(:user) { create(:user) }
  let!(:company) { create(:company) }
  let!(:job_listing) {create(:job_listing, company: company)}

  before do
    sign_in user
  end


  describe "GET /job_listings" do
    it "returns http success" do
      get job_listings_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /job_listings/:id" do
    it "returns http success" do
      get job_listing_path(job_listing)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /job_listings/new" do
    it "returns http success" do
      get new_job_listing_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /job_listings" do

    let(:valid_params) do
      {
        job_listing: {
          company_id: company.id,
          title: "Super Job"
        }
      }
    end
    it "creates a new job listing and redirects" do
      p valid_params
      expect{
        post job_listings_path, params: valid_params
      }.to change(JobListing, :count).by(1)
      expect(response).to redirect_to(job_listing_path(JobListing.last))
    end
  end

  describe "GET /job_listings/:id/edit" do
    it "returns http success" do
      get edit_job_listing_path(job_listing)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /job_listings/:id" do
    let(:update_params) do
      {
        job_listing: {
          title: "Dev H/F ROR FULLSTACK JUNIOR 30 ANS D'XP"
        }
      }
    end

    it "rupdates the job listing and redirects" do
      patch job_listing_path(job_listing), params: update_params
      job_listing.reload
      expect(job_listing.title).to eq("Dev H/F ROR FULLSTACK JUNIOR 30 ANS D'XP")
      expect(response).to redirect_to(job_listing_path(job_listing))
    end
  end

  describe "DELETE /job_listings/:id" do
    it "deletes the job_listing and redirects" do
      expect {
          delete job_listing_path(job_listing)
        }.to change(JobListing, :count).by(-1)
      expect(response).to redirect_to(job_listings_path)
    end
  end

end
