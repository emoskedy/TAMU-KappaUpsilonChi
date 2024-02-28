class Admin::OfficerEmailsController < ApplicationController
    before_action :authenticate_admin!
  
    def index
      @officer_emails = officer_emails
    end
  
    def create
      new_email = params[:new_email]
  
      if new_email.present?
        officer_emails << new_email
        save_officer_emails
        flash[:notice] = "Email added to officer list successfully."
      else
        flash[:alert] = "Email cannot be blank."
      end
  
      redirect_to admin_officer_emails_path
    end
  
    private
  
    def save_officer_emails
      # Your implementation to save officer emails
    end
  
    def officer_emails
      # Your implementation to retrieve officer emails
    end
  end