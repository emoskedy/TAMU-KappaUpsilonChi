# spec/support/omniauth_helpers.rb
module OmniAuthHelpers
  def google_oauth_authentication
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

  def google_oauth_admin
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

  def check_and_sub_account
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
end

# spec/rails_helper.rb (or wherever you load your support files)
RSpec.configure do |config|
  config.include OmniAuthHelpers
end
