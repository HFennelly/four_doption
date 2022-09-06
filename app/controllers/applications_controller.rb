class ApplicationsController < ApplicationController
  before_action :set_pet, only: [:create, :edit, :update]

  def create
    @application = Booking.new(application_params)
    @application.pet = @pet
    @application.user = current_user
  end

  def edit

  end

  def update

  end

  private

  def booking_params
    params.require(:application).permit(:requirements)
  end

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end
end
