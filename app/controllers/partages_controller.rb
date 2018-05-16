class PartagesController < ApplicationController
  before_action :authenticate

  def index
    @listes_partagees = Liste.owner_and_shared_with session[:user_id]
  end

  def new
    @partage = Partage.new
    @listes = Liste.where(user_id: session[:user_id])
  end

  def create
    @users =  User.where("lower(name) = lower(?) AND id != ?", "#{params[:partage][:destinataire_name]}","#{session[:user_id].to_i}").to_a
    if @users.size != 1
      @users = User.where("lower(name) LIKE lower(?) AND id != ?", "%#{params[:partage][:destinataire_name]}%","#{session[:user_id].to_i}").to_a
    end

    @partage = Partage.new
    @partage.found = @users.map{|u| u.name}
    @partage.proprietaire_id = session[:user_id]
    @partage.destinataire_id = @users[0].id if @partage.found.size == 1

    @partage.liste_id = params[:partage][:liste_id]
    if @partage.save
        redirect_to "/", notice: "Nouveau partage créé"
    else
        @listes = Liste.where(user_id: session[:user_id])
        render new_partage_path
    end
  end

  def destroy
    @partage = Partage.find(params[:id])
    @partage.destroy
    redirect_to "/", notice:"Partage supprimé"
  end

end
