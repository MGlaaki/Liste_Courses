class SessionsController < ApplicationController
  before_action :authenticate, only: [:destroy]

  def new
    redirect_to "/", notice: "Vous êtes déjà connecté" if session[:user_id]
  end

  def create
    @user = User.authenticate(params[:name], params[:password])
    if @user
      session[:user_id] = @user.id
      session[:user_name] = @user.name
      redirect_to "/", notice: "Vous êtes connecté"
    else
      redirect_to log_in_path, alert: "Mauvais nom d'utilisateur ou mot de passe"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/", notice: "Vous êtes déconnecté"
  end
end
