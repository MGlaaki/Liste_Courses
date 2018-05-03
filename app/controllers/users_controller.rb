class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id], session[:user_name] = @user.id,@user.name
      redirect_to '/', notice: "Bienvenue sur le site !"
    else
      render new_user_path
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

end
