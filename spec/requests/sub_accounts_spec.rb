require 'rails_helper'


RSpec.describe "SubAccounts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/sub_accounts/index"
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/sub_accounts/new"
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/sub_accounts/edit"
      follow_redirect!
      expect(response).to have_http_status(:success)
    end
  end

end