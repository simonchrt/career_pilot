require 'rails_helper'

RSpec.describe "ApplicationSteps", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/application_steps/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/application_steps/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/application_steps/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
