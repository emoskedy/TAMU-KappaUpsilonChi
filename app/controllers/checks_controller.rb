class ChecksController < ApplicationController
  before_action :set_check, only: %i[ show edit update destroy ]
  before_action :load_sub_accounts, only: %i[new edit update update_review review]
  before_action :require_officer_or_admin, only: %i[review update_review destroy]
  before_action :check_profile_existence, only: [:new]
  before_action :set_person
  
  def index
    @checks = if current_admin.is_admin? || current_admin.is_officer?
                Check.all
              else
                current_admin.checks
              end
  end

  def new
    @check = Check.new(
      organization_name: 'Kappa Upsilon Chi',
      account_number: 945470,
      payment_method: 'direct_deposit',
      payable_name: @current_person.name,
      payable_address: @current_person.address,
      payable_phone_number: @current_person.phone_number
    )
  end

  def create
    @check = current_admin.checks.new(check_params)

    respond_to do |format|
      if @check.save
        format.html { redirect_to check_notes_path(@check), notice: "Form was successfully created" }
        format.json { render :show, status: :created, location: @check }
      else
        format.html { render :new, status: :unprocessable_entity}
        format.json { render json: @check.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit
    return unless @check.approved?

    redirect_to checks_url, alert: "Cannot edit a check that has been approved"
  end

  def update
    respond_to do |format|
      if @check.update(check_params)
        format.html {redirect_to check_url(@check), notice: "Form was successfully updated"}
        format.json { render :show, status: :ok, location: @check }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @check.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @check.destroy

    respond_to do |format|
      format.html { redirect_to checks_url, notice: "Form was successfully destroyed" }
      format.json { head :no_content }
    end
  end

  def review
    @check = Check.find(params[:id])
  end

  # def update_review
  #   @check = Check.find(params[:id])

  #   if @check.update(check_params)
  #     redirect_to @check, notice: 'Form reviewed successfully.'
  #   else
  #     render :review
  #   end
  # end

  def past
    @checks = if current_admin.is_admin? || current_admin.is_officer?
                Check.all
              else
                current_admin.checks
              end
  end

  def approved
    @checks = Check.where(approval_status: :approved)
    render 'past'
  end

  def denied
    @checks = Check.where(approval_status: :denied)
    render 'past'
  end

  private

  def set_check
    @check = Check.find(params[:id])
  end

  def load_sub_accounts
    @sub_accounts = SubAccount.all
  end

  def set_person
    @current_person = Person.find_by(email: current_admin.email)
  end

  def show
    @check = Check.find(params[:id])
    @notes = @check.notes
  end

  def require_officer_or_admin
    return if current_admin.officer? || current_admin.admin?

    flash[:alert] = "You are not authorized to perform this."
    redirect_to root_path
  end

  def check_profile_existence
    email = current_admin.email
    return if Person.exists?(email:)

    flash[:alert] = "You need to create a profile first."
    redirect_to new_person_path
  end

  def check_params
    params.require(:check).permit(:description, :organization_name, :account_number, :date, :payable_phone_number, :payable_address, :payment_method, :date, :role, :payable_name, :sub_account_id,
                                  :approval_status, :comments, :dollar_amount, :travel, :food, :office_supplies, :utilities, :membership, :services_and_other_income, :clothing, :rent, :other_expenses, :items_for_resale)
  end
end