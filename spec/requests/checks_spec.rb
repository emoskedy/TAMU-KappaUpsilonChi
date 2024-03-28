require 'rails_helper'

RSpec.describe "Checks", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/checks/index"
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/checks/new"
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/checks/edit"
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

end
