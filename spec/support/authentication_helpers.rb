module AuthenticationHelpers
    def user_sign_in_via_google
      visit '/admins/sign_in' # Adjust this path based on your actual route
      # The actual authentication is mocked by OmniAuth, no need to interact with Google's login page
      click_on 'Google'
    end
  end
  
  RSpec.configure do |config|
    config.include AuthenticationHelpers, type: :feature
  end