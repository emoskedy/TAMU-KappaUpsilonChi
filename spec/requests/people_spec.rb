require 'rails_helper'

RSpec.describe "People", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/people/index"
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/people/new"
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/people/edit"
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end
end
