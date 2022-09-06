class PetsController < ApplicationController
  def index
    @pets = Pet.where(user: current_user)
  end
end
