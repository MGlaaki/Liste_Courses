class UsersController < ApplicationController
  before_action :authenticate, only: [:show, :destroy, :edit]

  def show
    @user = active_user
  end

  def new
    @user = User.new
  end

  def edit
    @user = active_user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id], session[:user_name] = @user.id,@user.pretty_name
      redirect_to '/', notice: "Bienvenue sur le site !"
    else
      render new_user_path
    end

  end

  def update
    @user = User.authenticate(params[:user][:name],params[:user][:old_password])
    if @user
      @user.password = params[:user][:new_password]
      @user.password_confirmation = params[:user][:new_password_confirmation]
      if @user.save
       redirect_to '/', notice: "Mot de passe modifié"
     else
       render edit_user_path
     end
    else
      fail
    end


  end

  def destroy
    @user = active_user
    @user.destroy
    session[:user_id] = nil

    redirect_to '/', notice: "Utilisateur #{session[:user_name]} supprimé."
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def active_user
    @user = User.find session[:user_id]
  end

end
