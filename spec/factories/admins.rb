FactoryBot.define do
    factory :admin do
      email { "test@gmail.com" }
      # Add other attributes here
      full_name {"Test User"}
      uid {"123456789"}
    end
  end