require 'rails_helper'

RSpec.describe SubAccount, type: :model do
    it 'is valid with sub-account number and owner name' do
        sub_account = SubAccount.new(
            sub_account_number: 123323,
            owner_name: 'Jeff Jefferson'
        )

        expect(sub_account).to be_valid
    end

    it 'is not valid without sub-account number' do
        sub_account = SubAccount.new(
            sub_account_number: nil,
            owner_name: 'Jeff Jefferson'
        )

        expect(sub_account).to_not be_valid
    end
end
