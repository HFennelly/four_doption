class PetsController < ApplicationController
  def index
    @pets = Pet.where(user: current_user)
  end

  def show
    @pet = Pet.find(params[:id])
  end
end
