# location: spec/features/checks_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Creating a new sub-account as a member', type: :feature do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123456789',
      info: {
        name: 'Test User',
        email: 'test@gmail.com',
        image: 'http://example.com/image.png'
      },
      credentials: {
        token: 'mock_token',
        refresh_token: 'mock_refresh_token',
        expires_at: Time.now + 1.week
      }
    })

    visit '/admins/sign_in'
    click_on 'Sign In'
  end

  scenario 'Not allow to create sub account number' do
    visit new_sub_account_path
    expect(page).to have_content('You are not allowed to access this page')
  end
end

RSpec.describe 'Creating a new sub-account as an officer/admin', type: :feature do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123456789',
      info: {
        name: 'Test User',
        email: 'test@gmail.com',
        image: 'http://example.com/image.png'
      },
      credentials: {
        token: 'mock_token',
        refresh_token: 'mock_refresh_token',
        expires_at: Time.now + 1.week
      }
    })

    @admin_user = Admin.create!(
      email: 'test@gmail.com', 
      full_name: 'Test User',
      is_officer: true,
      is_admin: true
    )

    visit '/admins/sign_in'
    click_on 'Sign In'
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
end

RSpec.describe 'Updating a sub-account', type: :feature do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123456789',
      info: {
        name: 'Test User',
        email: 'test@gmail.com',
        image: 'http://example.com/image.png'
      },
      credentials: {
        token: 'mock_token',
        refresh_token: 'mock_refresh_token',
        expires_at: Time.now + 1.week
      }
    })

    @admin_user = Admin.create!(
      email: 'test@gmail.com', 
      full_name: 'Test User',
      is_officer: false,
      is_admin: true
    )

    visit '/admins/sign_in'
    click_on 'Sign In'
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

RSpec.describe 'Creating a check form as a member', type: :feature do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123456789',
      info: {
        name: 'Test User',
        email: 'test@gmail.com',
        image: 'http://example.com/image.png'
      },
      credentials: {
        token: 'mock_token',
        refresh_token: 'mock_refresh_token',
        expires_at: Time.now + 1.week
      }
    })

    visit '/admins/sign_in'
    click_on 'Sign In'
  end

  before do
    @check = Check.new(
      description: 'This is a testing description',
      organization_name: 'Kappa Upsilon Chi',
      account_number: 945470,
      payable_name: 'Test Payee',
      date: Date.today
    )
    @sub_account = SubAccount.create(
      sub_account_number: 12344321,
      owner_name: "Test User",
    )
    @check.sub_account = @sub_account # Associate models directly
    @check.save! # Save the check object
  end
  

  scenario 'valid inputs' do
    visit edit_check_path(@check)
    expect(page).to have_field("check[description]", with: 'This is a testing description')
    expect(page).to have_field("check[organization_name]", with: 'Kappa Upsilon Chi')
    expect(page).to have_field("check[account_number]", with: 945470)

    visit check_path(@check)
    expect(page).to have_content('This is a testing description')
  end
  
  scenario 'Not allow to review the form' do
    visit check_path(@check)
    visit review_check_path(@check)
    expect(page).to have_content('You are not authorized to perform this')
  end
end

RSpec.describe 'Creating a check form as an officer/admin', type: :feature do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123456789',
      info: {
        name: 'Test User',
        email: 'test@gmail.com',
        image: 'http://example.com/image.png'
      },
      credentials: {
        token: 'mock_token',
        refresh_token: 'mock_refresh_token',
        expires_at: Time.now + 1.week
      }
    })

    @admin_user = Admin.create!(
      email: 'test@gmail.com', 
      full_name: 'Test User',
      is_officer: false,
      is_admin: true
    )

    visit '/admins/sign_in'
    click_on 'Sign In'
  end

  before do
    @check = Check.new(
      organization_name: 'Kappa Upsilon Chi',
      account_number: 945470,
      payable_name: 'Test Payee',
      date: Date.today
    )
    @sub_account = SubAccount.create(
      sub_account_number: 12344321,
      owner_name: "Test User",
    )
    @check.sub_account = @sub_account # Associate models directly
    @check.save! # Save the check object
  end
  
  scenario 'valid sub-account' do
    visit check_path(@check)
    visit review_check_path(@check)
    expect(page).to have_field("check[sub_account_id]", with: @sub_account.id)
  end
end


