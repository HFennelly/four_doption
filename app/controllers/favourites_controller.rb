class FavouritesController < ApplicationController
  def index
    @favourites = Favourite.all
  end

  def destroy
    @favourite = Favourite.find(params[:id])
    # @pet = @favourite.pet
    @favourite.destroy
    # redirect_to pet_path(@pet), status: :see_other
  end

  def favourite_params
    params.require(:favourite)
  end
  # for tommorow
  # need to be able to delete a favourite from a list of favourites (there is no favourites show page here)
end
