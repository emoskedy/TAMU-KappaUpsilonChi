require 'rails_helper'

RSpec.describe Admin, type: :model do
    it "is valid with setting to officer" do
        admin = Admin.new
        admin.officer = true
        expect(admin.is_officer).to eq(true)
    end

    it "is valid with setting to admin" do
        admin = Admin.new
        admin.admin = true
        expect(admin.is_admin).to eq(true)
    end

    it "is valid with setting to member" do
        admin = Admin.new
        expect(admin.member?).to eq(true)
    end
end