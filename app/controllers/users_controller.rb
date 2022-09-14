class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @rescue = User.select do |user|
      rescue_email = current_user.email.split("@")[1]
      user.domain != nil && user.domain.include?(rescue_email)
        # return true

    end
    if @rescue == []
      @pets = @user.pets
    else
    @pets = @rescue.first.pets + current_user.pets
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :address, :password, :photo)
  end


end
