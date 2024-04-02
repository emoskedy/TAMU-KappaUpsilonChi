module Admins
  class AdminController < ApplicationController
    before_action :authenticate_admin!
    before_action :check_admin_role

    def index
      # Get the currently logged-in admin's email
      current_admin_email = current_admin.email
  
      # Retrieve all admins excluding the currently logged-in admin and sort them
      @all_admins = Admin.where.not(email: current_admin_email)

      case params[:status]
      when 'Admin'
        @all_admins = @all_admins.where(is_admin: true)
      when 'Officer'
        @all_admins = @all_admins.where(is_officer: true)
      when 'Member'
        @all_admins = @all_admins.where(is_admin: false, is_officer: false)
      else 
        @all_admins = @all_admins.order(is_admin: :desc, is_officer: :desc)
      end

      case params[:sort]
      when 'Z-A'
        @all_admins = @all_admins.order(full_name: :desc)
      else
        @all_admins = @all_admins.order(full_name: :asc)
      end
    end

    def update
      admins_params = params[:admins]
      if admins_params.present?
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
        redirect_to admins_admin_index_path, alert: 'Email address already existed.'
      elsif @admin.save
        # Try to save the admin
        redirect_to admins_admin_index_path, notice: 'User created successfully.'
      else
        redirect_to admins_admin_index_path, alert: 'Failed to create user.'
      end
    end

    def search
      @all_admins = if params[:search].present?
                      Admin.where("lower(full_name) LIKE ?", "%#{params[:search].downcase}%")
                    else
                      current_admin_email = current_admin.email  
                      # Retrieve all admins excluding the currently logged-in admin and sort them
                      @all_admins = Admin.where.not(email: current_admin_email)
                                        .order(is_admin: :desc, is_officer: :desc, email: :asc)
                    end
      render 'index'
    end 

    def destroy
      admin = Admin.find(params[:id])
      admin.destroy
      redirect_to admins_admin_index_path, notice: "User #{admin.email} has been deleted."
    end

    private

    def check_admin_role
      return if current_admin.is_admin?

      flash[:alert] = 'You are not allowed to access the admin page.'
      redirect_to root_path
    end

    def admin_params
      params.require(:admin).permit(:email, :full_name)
    end
  end
end
