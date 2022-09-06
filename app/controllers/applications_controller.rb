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

  end

  def update

  end

  def show
    @application = Application.find(params[:id])
  end

  def destroy
    @application = Application.find(params[:id])
    @pet = @application.pet
    @application.destroy
    redirect_to pet_path(@pet), status: :see_other
  end

  def index
    @application = Application.all
  end

  private

  def application_params
    params.require(:application).permit(:requirements)
  end

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end
end
