class ChecksController < ApplicationController
  before_action :set_check, only: %i[ show edit update destroy ]
  before_action :load_sub_accounts, only: [:new, :edit]


  def index
    @checks = Check.all
  end

  def new
    @check = Check.new(
      organization_name: 'Kappa Upsilon Chi',
      account_number: 945470,
      payment_method: 'direct_deposit'
    )
  end

  def create
    @check = Check.new(check_params)
    @check.dollar_amounts = params[:check][:dollar_amounts].split(",").map(&:to_d)

    respond_to do |format|
      if @check.save
        format.html { redirect_to check_url(@check), notice: "Form was successfully created" }
        format.json { render :show, status: :created, location: @check }
      else
        format.html { render :new, status: :unprocessable_entity}
        format.json { render json: @check.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @check.update(check_params)
        format.html {redirect_to check_url(@check), notice: "Form was successfully updated"}
        format.json { render :show, status: :ok, location: @check }
      else
        format.html { render :edit, status: unprocessable_entity }
        format.json { render josn: @check.errors, status: unprocessable_entity }
      end
    end
  end

  def destroy
    @check.destroy

    respond_to do |format|
      format.html { redirect_to checks_url, notice: "Form was successfuly destroyed" }
      format.json { head :no_content }
    end
  end

  private

  def set_check
    @check = Check.find(params[:id])
  end

  
  def load_sub_accounts
    @sub_accounts = SubAccount.all
  end
  

  def show
    @check = Check.find(params[:id])
  end

  def check_params
    params.require(:check).permit(:description, :organization_name, :account_number, :date, :payable_phone_number, :payable_address, :role, :payment_method, :date, :payable_name, :sub_account_id, dollar_amounts: [])
  end
end