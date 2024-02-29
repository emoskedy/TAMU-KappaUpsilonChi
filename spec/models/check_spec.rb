require 'rails_helper'

RSpec.describe Check, type: :model do

    it "is valid with all attributes filled out" do
        check = Check.new(
            organization_name: 'Kappa Upsilon Chi',
            account_number: 945470,
            payable_name: 'Test Payee',
            date: Date.today
        )
        @sub_account = SubAccount.create(
            sub_account_number: 12344321,
            owner_name: "Test User",
          )
          check.sub_account = @sub_account # Associate models directly
          check.save! # Save the check object

        expect(check).to be_valid
    end

    it "is not valid without sub-account" do
        check = Check.new(
            organization_name: 'Kappa Upsilon Chi',
            account_number: 945470,
            payable_name: 'Test Payee',
            date: Date.today,
            sub_account_id:nil
        )

        expect(check).to_not be_valid
    end

    it "is not valid without date" do
        check = Check.new(
            organization_name: 'Kappa Upsilon Chi',
            account_number: 945470,
            payable_name: 'Test Payee',
            date: Date.today
        )
        @sub_account = SubAccount.create(
            sub_account_number: 12344321,
            owner_name: "Test User",
          )
          check.sub_account = @sub_account # Associate models directly
          check.save! # Save the check object

          check.date = nil

        expect(check).to_not be_valid
    end




   
end
  