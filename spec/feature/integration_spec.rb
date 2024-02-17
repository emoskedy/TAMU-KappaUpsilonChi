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
    visit '/admins/sign_in' # Adjust this path based on your actual route
      # The actual authentication is mocked by OmniAuth, no need to interact with Google's login page
    click_on 'Google'
  end
    
  scenario 'valid inputs' do
    visit new_check_path
    fill_in "check[organization_name]", with: 'Kappa Upsilon Chi'
    fill_in "check[account_number]", with: 945470
    # select 'direct_deposit', from: "check[payment_method]"
    click_on 'Create Check'
    visit checks_path
    # expect(page).to have_current_path(checks_path)
    expect(page).to have_content('Welcome to the Admin Dashboard')
  end
end


