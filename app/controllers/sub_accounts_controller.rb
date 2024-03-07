class SubAccountsController < ApplicationController
    before_action :set_sub_account, only: [:show, :edit, :update, :destroy]
    before_action :check_admin_role

    def index
        @sub_accounts = SubAccount.all
    end

    def show
        @sub_account = SubAccount.find(params[:id])
    end

    def new
        @sub_account = SubAccount.new
    end

    def create
        @sub_account = SubAccount.new(sub_account_params)

        respond_to do |format|
            if @sub_account.save
                format.html { redirect_to sub_account_url(@sub_account), notice: "Sub-account was successfully created." }
                format.json { render :show, status: :created, location: @sub_account }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @sub_account.errors, status: :unprocessable_entity }
            end
        end
    end

    def edit
    end

    def update
        if @sub_account.update(sub_account_params)
            redirect_to @sub_account, notice: 'Sub-account was successfully updated.'
        else
            render :edit
        end
    end

    def destroy
        if @sub_account.checks.exists?
            flash[:alert] = "You cannot delete a sub-account with associated checks."
            redirect_to sub_accounts_url
        else
            @sub_account.destroy
            redirect_to sub_accounts_url, notice: 'Sub-account was successfully destroyed.'
        end
    end

    private

    def check_admin_role
        unless current_admin.is_officer? || current_admin.is_admin?
          flash[:alert] = "You are not allowed to access this page."
          redirect_to root_path
        end
    end   

    def set_sub_account
        @sub_account = SubAccount.find(params[:id])
    end

    def sub_account_params
        params.require(:sub_account).permit(:sub_account_number, :owner_name)
    end
end



