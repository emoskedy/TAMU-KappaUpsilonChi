module RequestAuthHelpers
    def authenticate_admin
      admin = FactoryBot.create(:admin) # Ensure you have a factory for the admin
      allow_any_instance_of(ApplicationController).to receive(:current_admin).and_return(admin)
    end
end
