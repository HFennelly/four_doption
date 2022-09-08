class PetsController < ApplicationController
  def index
    if params[:query].present?
      sql_query = <<~SQL
        pets.location @@ :query
      SQL
      @pets = Pet.where(sql_query, query: "%#{params[:query]}%")
    else
      @pets = Pet.all
    end

    if params[:sex] != "" && params[:sex].present?
      @pets = @pets.where(sex: params[:sex])
    end

    if params[:species] != "" && params[:species].present?
      @pets = @pets.where(species: params[:species])
    end

    if params[:breed] != "" && params[:breed].present?
      @pets = @pets.where(breed: params[:breed])
    end

    if params[:age] != "" && params[:age].present?
      @pets = @pets.where(age: params[:age])
    end

    if params[:size] != "" && params[:size].present?
      @pets = @pets.where(size: params[:size])
    end

    if params.keys.count > 2
      @searching = true
    else
      @searching = false
    end
  end

  def show
    @pet = Pet.find(params[:id])
    @application = Application.new
    @favourite = Favourite.new
    @pets = Pet.all
    # The `geocoded` scope filters only pets with coordinates
    @markers = [
      {
        lat: @pet.latitude,
        lng: @pet.longitude,
        info_window: render_to_string(partial: "info_window", locals: {pet: @pet}),
        image_url: helpers.asset_url("paw_print.png")
      }
    ]
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user
    @pet.save
    redirect_to pet_path(@pet)
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    if @pet.update(pet_params)
      redirect_to pet_path(@pet)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy
    redirect_to pets_path, status: :see_other
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :species, :breed, :age, :location, :sex, :size, :needs_garden, :adopted, :photo)
  end
end
