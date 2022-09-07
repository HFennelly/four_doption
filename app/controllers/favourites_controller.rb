class FavouritesController < ApplicationController
  def index
    @favourites = Favourite.all
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    @pet = @favourite.pet
    @favourite.destroy
    if request.referrer.include?("/favourites")
      redirect_to favourites_path, status: :see_other
    else
      redirect_to pet_path(@pet), status: :see_other
    end
  end


  def create
    @favourite = Favourite.new
    @favourite.user = current_user
    @pet = Pet.find(params[:pet_id])
    @favourite.pet = @pet
    @favourite.save
    redirect_to pet_path(@pet), notice: "You've favourited #{@pet.name}"
  end

  private

  # for tommorow
  # need to be able to delete a favourite from a list of favourites (there is no favourites show page here)
end
