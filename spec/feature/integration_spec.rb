# location: spec/features/checks_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Creating a check form', type: :feature do
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
    # Create an admin account
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
  

  scenario 'valid inputs' do
    visit edit_check_path(@check)

    expect(page).to have_field("check[organization_name]", with: 'Kappa Upsilon Chi')
    expect(page).to have_field("check[account_number]", with: 945470)
    
    visit check_path(@check)
    visit review_check_path(@check)
    expect(page).to have_field("check[sub_account_id]", with: @sub_account.id)
  end

  scenario ''
end


