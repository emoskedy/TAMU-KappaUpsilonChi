class ChecksController < ApplicationController
  def index
    @checks = Check.all
  end

  def new
    @check = Check.new
  end

  def create
    @check = Check.new(check_params)

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

  def set_check
    @check = Check.find(params[:id])
  end

  def show
    @check = Check.find(params[:id])
  end

  def check_params
    params.require(:check).permit(:description)
  end
end
