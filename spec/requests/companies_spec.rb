require 'rails_helper'

RSpec.describe "Companies", type: :request do
  let(:user) { create(:user) }
  let!(:company) { create(:company) }

  before do
    sign_in user
  end

  describe "GET /companies" do
    it "returns http success" do
      get companies_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /companies/:id" do
    it "returns http success" do
      get company_path(company)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /companies/new" do
    it "returns http success" do
      get new_company_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /companies" do
    let(:valid_params) do
      {
        company: {
          name: "Test Company",
          website: "https://example.com",
          industry: "Technology",
          location: "Paris",
          size: "small"
        }
      }
    end

    it "creates a new company and redirects" do
      expect {
        post companies_path, params: valid_params
      }.to change(Company, :count).by(1)

      expect(response).to redirect_to(company_path(Company.last))
    end
  end

  describe "GET /companies/:id/edit" do
    it "returns http success" do
      get edit_company_path(company)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /companies/:id" do
    let(:update_params) do
      {
        company: {
          name: "Updated Company",
          industry: "Finance"
        }
      }
    end

    it "updates the company and redirects" do
      patch company_path(company), params: update_params

      company.reload
      expect(company.name).to eq("Updated Company")
      expect(company.industry).to eq("Finance")
      expect(response).to redirect_to(company_path(company))
    end
  end


end
