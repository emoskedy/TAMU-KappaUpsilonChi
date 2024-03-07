# location: spec/features/checks_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Omniauth failure handling', type: :feature do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
    visit 'admins/sign_in'
    click_on 'Sign In'
  end
  
  scenario 'redirecting to new_admin_session_path after failure' do
    expect(page).to have_current_path(new_admin_session_path)
  end
end


RSpec.describe 'Google OAuth2 authentication', type: :feature do
  before do
    google_oauth_authentication
  end

  scenario 'correct redirect after signing out' do
    click_link 'Sign Out'
    expect(current_path).to eq(new_admin_session_path)
  end

  scenario 'already sign in' do
    allow(Admin).to receive(:from_google).and_return(nil)

    visit '/admins/auth/google_oauth2/callback'
    expect(page).to have_content("You are already signed in")
  end
end

RSpec.describe 'Creating a new sub-account as a member', type: :feature do
  before do
    google_oauth_authentication
  end

  scenario 'Not allow to create sub account number' do
    visit new_sub_account_path
    expect(page).to have_content('You are not allowed to access this page')
  end
end

RSpec.describe 'Creating a new sub-account as an officer/admin', type: :feature do
  before do
    google_oauth_admin
  end

  scenario 'valid inputs' do
    visit new_sub_account_path
    fill_in 'sub_account[sub_account_number]', with: '123456'
    fill_in 'sub_account[owner_name]', with: 'Test Owner'
    click_on 'Create Sub account'
    expect(page).to have_content('Sub-account was successfully created.')
    expect(page).to have_content('Sub-Account Number: 123456')
    expect(page).to have_content('Sub-Account Owner: Test Owner')
  end

  scenario 'invalid inputs' do
    visit new_sub_account_path
    fill_in 'sub_account[sub_account_number]', with: ''
    fill_in 'sub_account[owner_name]', with: 'Test Owner'
    click_on 'Create Sub account'
    expect(page).to have_content("Sub account number can't be blank")
  end

  before do
    @sub_account = SubAccount.create(
      sub_account_number: '123456',
      owner_name: 'Test Owner'
    )
  end

  scenario 'valid update' do
    visit edit_sub_account_path(@sub_account)
    fill_in 'sub_account[sub_account_number]', with: '789012'
    fill_in 'sub_account[owner_name]', with: 'Updated Owner'
    click_on 'Update Sub account'
    expect(page).to have_content('Sub-account was successfully updated.')
    expect(page).to have_content('Sub-Account Number: 789012')
    expect(page).to have_content('Sub-Account Owner: Updated Owner')
  end

  scenario 'invalid update' do
    visit edit_sub_account_path(@sub_account)
    fill_in 'sub_account[sub_account_number]', with: ''
    fill_in 'sub_account[owner_name]', with: 'Updated Owner'
    click_on 'Update Sub account'
    expect(page).to have_content("Sub account number can't be blank")
  end

  scenario 'valid delete' do
    visit sub_account_path(@sub_account)
    expect(page).to have_content('Sub-Account Number: 123456')
    click_on 'Destroy this sub-account'
    expect(page).to have_content('Sub-account was successfully destroyed.')
    expect(page).not_to have_content('Sub-Account Number: 123456')
  end
end

RSpec.describe 'Creating a check form', type: :feature do
  before do
    google_oauth_authentication
  end

  before do
    @sub_account = SubAccount.create(
      sub_account_number: 12344321,
      owner_name: "Test User",
    )
    @sub_account.save!
  end

  scenario 'valid input' do 
    visit new_check_path
    click_on 'Create Person'
    visit new_check_path
    fill_in 'check[organization_name]', with: 'Kappa Upsilon Chi'
    fill_in 'check[account_number]', with: 945470
    fill_in 'check[payable_name]', with: 'Test Payee'
    select '2023', from: 'check_date_1i'
    select 'January', from: 'check_date_2i'
    select '15', from: 'check_date_3i'
    click_on 'Create Check'
    expect(page).to have_content('Form was successfully created')
  end

  scenario 'invalid input' do 
    visit new_check_path
    click_on 'Create Person'
    visit new_check_path
    fill_in 'check[organization_name]', with: 'Kappa Upsilon Chi'
    fill_in 'check[account_number]', with: 945470
    fill_in 'check[payable_name]', with: 'Test Payee'
    click_on 'Create Check'
    expect(page).to have_content('error')
  end
end

RSpec.describe 'Creating a check form as a member', type: :feature do
  before do
    google_oauth_authentication
  end

  before do
    check_and_sub_account
  end

  scenario 'valid inputs' do
    visit edit_check_path(@check)
    expect(page).to have_field("check[description]", with: 'This is a testing description')
    expect(page).to have_field("check[organization_name]", with: 'Kappa Upsilon Chi')
    expect(page).to have_field("check[account_number]", with: 945470)
    visit check_path(@check)
    expect(page).to have_content('This is a testing description')
    expect(page).to have_content("Description: #{@check.description}")
    expect(page).to have_content("Organization Name: #{@check.organization_name}")
  end
  
  scenario 'not allow to edit after approval' do
    @check.update(approval_status: 'approved')
    visit edit_check_path(@check)
    expect(page).to have_content('Cannot edit a check that has been approved')
  end

  scenario 'invalid update' do
    visit edit_check_path(@check)
    fill_in 'check[account_number]', with: nil
    click_on 'Update Check'
    expect(page).to have_content('error')
  end

  scenario 'not authorized to delete' do
    visit check_path(@check)
    click_on 'Destroy this form'
    expect(page).to have_content('You are not authorized to perform this')
  end

  scenario 'Not allow to review the form' do
    visit check_path(@check)
    visit review_check_path(@check)
    expect(page).to have_content('You are not authorized to perform this')
  end

  scenario 'valid total dollar amount' do
    visit edit_check_path(@check)
    fill_in 'check[travel]', with: 25.0
    fill_in 'check[food]', with: 15.0
    fill_in 'check[office_supplies]', with: 10.0
    fill_in 'check[utilities]', with: 20.0
    fill_in 'check[membership]', with: 5.0
    fill_in 'check[clothing]', with: 8.0
    fill_in 'check[rent]', with: 30.0
    fill_in 'check[other_expenses]', with: 12.0
    fill_in 'check[items_for_resale]', with: 7.0
    fill_in 'check[services_and_other_income]', with: 18.0
    click_on 'Update Check'
    visit check_path(@check)
    expect(page).to have_content('Total: 150')
  end
end

RSpec.describe 'Creating a check form as an officer/admin', type: :feature do
  before do
    google_oauth_admin
  end

  before do
    check_and_sub_account
  end
  
  scenario 'valid sub-account' do
    visit check_path(@check)
    visit review_check_path(@check)
    expect(page).to have_field("check[sub_account_id]", with: @sub_account.id)
  end

  scenario 'valid delete' do
    visit check_path(@check)
    click_on 'Destroy this form'
    expect(page).to have_content('Form was successfully destroyed')
  end

  scenario 'delete with a sub-account' do
    visit sub_account_path(@sub_account)
    click_on 'Destroy this sub-account'
    expect(page).to have_content('You cannot delete a sub-account with associated checks')
  end

  scenario 'valid review' do
    visit check_path(@check)
    visit review_check_path(@check)
    choose 'check_approval_status_approved'
    fill_in 'check[comments]', with: 'This is a test comment'
    click_on 'Update Approval Status and Comments'
    expect(page).to have_content('Form was successfully updated')
  end
end

RSpec.describe 'Creating a person', type: :feature do
  before do
    google_oauth_admin
  end

  scenario 'valid inputs' do
    visit new_check_path(@check)
    fill_in 'person[name]', with: 'Test User'
    fill_in 'person[email]', with: 'test@gmail.com'
    click_on 'Create Person'
    expect(page).to have_content('Person was successfully created')
  end

  before do
    @person = Person.create(
      name: 'John Doe',
      email: 'john@example.com',
      address: '123 Main St',
      uin: '123456789',
      phone_number: '555-1234',
      affiliation: 'Student'
    )
  end

  scenario 'valid update' do
    visit edit_person_path(@person)
    fill_in 'person[uin]', with: '456746713'
    click_on 'Update Person'
    expect(page).to have_content('Person was successfully updated')
  end

  scenario 'valid destroy' do
    visit person_path(@person)
    click_on 'Destroy this Profile'
    expect(page).to have_content('Person was successfully destroyed')
  end
end
