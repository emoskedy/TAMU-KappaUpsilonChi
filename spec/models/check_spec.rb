require 'rails_helper'

RSpec.describe Check, type: :model do
  it 'is valid with all attributes filled out' do
    check = Check.new(
      organization_name: 'Kappa Upsilon Chi',
      account_number: 945_470,
      payable_name: 'Test Payee',
      date: Date.today
    )
    @sub_account = SubAccount.create(
      sub_account_number: 12_344_321,
      owner_name: 'Test User'
    )
    check.sub_account = @sub_account # Associate models directly
    check.save! # Save the check object

    expect(check).to be_valid
  end

  it 'is not valid without sub-account' do
    sub_account = SubAccount.new(
      sub_account_number: nil,
      owner_name: 'Test User'
    )
    expect(sub_account).to_not be_valid
  end

  it 'is not valid without date' do
    check = Check.new(
      organization_name: 'Kappa Upsilon Chi',
      account_number: 945_470,
      payable_name: 'Test Payee',
      date: Date.today
    )
    @sub_account = SubAccount.create(
      sub_account_number: 12_344_321,
      owner_name: 'Test User'
    )
    check.sub_account = @sub_account # Associate models directly
    check.save! # Save the check object

    check.date = nil

    expect(check).to_not be_valid
  end

  it 'sets the approval status to pending' do
    check = Check.new(
      organization_name: 'Kappa Upsilon Chi',
      account_number: 945_470,
      payable_name: 'Test Payee',
      approval_status: 'approved',
      date: Date.today
    )
    @sub_account = SubAccount.create(
      sub_account_number: 12_344_321,
      owner_name: 'Test User'
    )
    check.sub_account = @sub_account # Associate models directly
    check.save! # Save the check object
    check.reset_status_to_pending
    expect(check.approval_status).to eq('pending')
  end
end
