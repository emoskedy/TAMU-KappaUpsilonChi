require 'rails_helper'

RSpec.describe "Checks", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/checks/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/checks/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/checks/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
