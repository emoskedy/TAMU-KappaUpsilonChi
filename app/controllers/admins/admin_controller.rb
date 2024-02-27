class Admins::AdminController < ApplicationController
    before_action :authenticate_admin!
    before_action :check_admin_role
  
    def index
        # Get the currently logged-in admin
        current_admin_email = current_admin.email

        # Retrieve all admins excluding the currently logged-in admin
        @all_admins = Admin.where.not(email: current_admin_email).order(:full_name)
    end
  
    def update
        admins_params = params[:admins] 
        admins_params.each do |admin_id, attributes|
          admin = Admin.find(admin_id)
          admin.update(is_officer: attributes[:is_officer], is_admin: attributes[:is_admin])
        end
        redirect_to admins_admin_index_path
    end

    private

    def check_admin_role
        unless current_admin.is_admin?
          flash[:alert] = "You are not allowed to access the admin page."
          redirect_to root_path
        end
    end   
end