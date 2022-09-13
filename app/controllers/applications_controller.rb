class ApplicationsController < ApplicationController
  before_action :set_pet, only: [:create, :edit, :update]


  def create
    @application = Application.new(application_params)
    @application.pet = @pet
    @application.user = current_user
    if @application.save
      redirect_to pet_path(@pet), notice: "your application has been received"
    else
      render 'pets/show'
    end
  end

  def edit
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
      @application.validated = true
    if @application.update(application_params)
      redirect_to pet_path(@pet), notice: "Your application has been updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @application = Application.find(params[:id])
    @message = Message.new
  end

  def destroy
    @application = Application.find(params[:id])
    @pet = @application.pet
    @application.destroy
    if request.referrer.include?("/applications/") # if on applications show page
      redirect_to pet_path(@pet), status: :see_other
    else # if on applications index page
      redirect_to applications_path, status: :see_other
    end
  end

  def index
    @applications = current_user.applications
  end

  private

  def application_params
    params.require(:application).permit(:requirements, :approved, :validated, :applicant_name, :applicant_age, :applicant_address, :applicant_household, :applicant_pets, :applicant_home, :applicant_hours, :applicant_garden, :applicant_information)
  end

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end
end
