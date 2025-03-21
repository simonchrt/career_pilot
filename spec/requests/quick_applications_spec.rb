require 'rails_helper'

RSpec.describe "QuickApplications", type: :request do

  let(:user) { create(:user) }
  let!(:company) { create(:company) }

  before do
    sign_in user
  end
  describe "GET /quick_applications/new" do
    it "returns http success" do
      get new_quick_application_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "post /quick_applications" do

    let(:new_company_params) do
      {
        "use_existing_company": "0",
        company: {
          name: "Test Company",
          website: "https://example.com",
          industry: "Technology",
          location: "Paris",
          size: "small"
        },
        job_listing: {
          title: "Super Job",
          description: "A great job opportunity",
          url: "https://example.com/job"
        },
        application: {
          applied_date: Date.today,
          status: "applied",
          notes: "Initial application"
        }
      }
    end

    it "creates a new application, job listing and a company when new company is selected" do
      expect {
        post quick_applications_path, params: new_company_params
      }.to change(Company, :count).by(1)
        .and change(JobListing, :count).by(1)
        .and change(Application, :count).by(1)

      # Vérifie que la redirection est correcte selon votre contrôleur
      expect(response).to redirect_to(application_path(Application.last))
    end


    let(:company_exist_params) do
      {
        use_existing_company: "1",
        company_id: Company.last.id
        job_listing: {
          title: "Super Job",
          description: "A great job opportunity",
          url: "https://example.com/job"
        },
        application: {
          applied_date: Date.today,
          status: "applied",
          notes: "Initial application"
        }
      }
    end


    it "creates a new application and a job listing when company already exist" do
      expect {
        post quick_applications_path, params: company_exist_params
      }.to change(JobListing, :count).by(1)
        .and change(Application, :count).by(1)

      # Vérifie que la redirection est correcte selon votre contrôleur
      expect(response).to redirect_to(application_path(Application.last))
    end


  end

end
