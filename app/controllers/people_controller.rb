class PeopleController < ApplicationController
    before_action :set_person, only: %i[ show edit update destroy ]

    def index
      @people = Person.all
      @current_admin_person = Person.find_by(email: current_admin.email)
      @other_people = Person.where.not(email: current_admin.email)
      @show_new_profile_button = @current_admin_person.nil?

    end
  
    def new
      @person = Person.new
    end
  
    def create
      @person = Person.new(person_params)
  
      respond_to do |format|
        if @person.save
          format.html { redirect_to person_url(@person), notice: "Form was successfully created" }
          format.json { render :show, status: :created, location: @person }
        else
          format.html { render :new, status: :unprocessable_entity}
          format.json { render json: @person.errors, status: :unprocessable_entity}
        end
      end
    end
  
    def edit
    end
  
    def update
      respond_to do |format|
        if @person.update(person_params)
          format.html {redirect_to person_url(@person), notice: "Form was successfully updated"}
          format.json { render :show, status: :ok, location: @person }
        else
          format.html { render :edit, status: unprocessable_entity }
          format.json { render josn: @person.errors, status: unprocessable_entity }
        end
      end
    end
  
    def destroy
      @person.destroy
  
      respond_to do |format|
        format.html { redirect_to people_url, notice: "Form was successfuly destroyed" }
        format.json { head :no_content }
      end
    end
  
    def set_person
      @person = Person.find(params[:id])
    end
  
    def show
      @person = Person.find(params[:id])
    end
  
    def person_params
      params.require(:person).permit(:name, :email, :address, :uin, :phone_number, :affiliation)
    end


end
