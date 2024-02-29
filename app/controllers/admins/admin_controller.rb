class Admins::AdminController < ApplicationController
    before_action :authenticate_admin!
    before_action :check_admin_role
  
    def index
      # Get the currently logged-in admin's email
      current_admin_email = current_admin.email
    
      # Retrieve all admins excluding the currently logged-in admin and sort them
      @all_admins = Admin.where.not(email: current_admin_email)
                         .order(is_admin: :desc, is_officer: :desc, email: :asc)
    end
  
    def update
      admins_params = params[:admins]
      admins_params.each do |admin_id, attributes|
        admin = Admin.find(admin_id)
        case attributes[:role]
        when 'admin'
          admin.update(is_admin: true, is_officer: false)
        when 'officer'
          admin.update(is_admin: false, is_officer: true)
        when 'member'
          admin.update(is_admin: false, is_officer: false)
        end
      end
      redirect_to admins_admin_index_path
    end

    def new
      @admin = Admin.new
    end

    def create
      @admin = Admin.new(admin_params)
      
      # Check if the email is already taken
      if Admin.exists?(email: @admin.email)
        redirect_to admins_admin_index_path, alert: "Email address is already in use."
      else
        # Try to save the admin
        if @admin.save
          redirect_to admins_admin_index_path, notice: "User created successfully."
        else
          redirect_to admins_admin_index_path, alert: "Failed to create user."
        end
      end
    end    
  
    def destroy
      admin = Admin.find(params[:id])
      admin.destroy
      redirect_to admins_admin_index_path, notice: "User #{admin.email} has been deleted."
    end

    private

    def check_admin_role
        unless current_admin.is_admin?
          flash[:alert] = "You are not allowed to access the admin page."
          redirect_to root_path
        end
    end   

    def admin_params
      params.require(:admin).permit(:email, :full_name, :role)
    end
end