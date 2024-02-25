class Admins::AdminController < ApplicationController
    before_action :authenticate_admin!
    before_action :check_admin_role
  
    def index
        @all_admins = Admin.all
    end
  
    private
  
    def check_admin_role
        unless current_admin.is_admin?
          flash[:alert] = "You are not allowed to access the admin page."
          redirect_to root_path
        end
    end      
end