class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to '/', notice: "Bienvenue sur le site !"
    else
      redirect_to new_user_path, alert: "Un problème a empêché la création de votre compte."
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

end
