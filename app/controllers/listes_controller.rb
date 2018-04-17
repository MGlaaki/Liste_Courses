class ListesController < ApplicationController

  def index
    @listes = Liste.where(user_id: session[:user_id])
  end

  def new
    @liste = Liste.new
  end

  def create
    @liste = Liste.new
    @liste.user_id = session[:user_id]
    @liste.nom_liste = params[:liste][:nom_liste].capitalize
    if @liste.save
      redirect_to liste_articles_path(liste_id: @liste.id)
    else
      if @liste.errors["nom_liste"][0].include? 'is too long'
        error = "Trop long nom !"
      elsif @liste.errors["nom_liste"][0].include? 'can\'t be blank'
        error = "Le nom de liste ne peut pas être vide"
      elsif @liste.errors["nom_liste"][0].include? 'has already been taken'
        error = "Le nom de liste doit être unique"
      end

      redirect_to new_liste_path, alert: error
    end
  end

  def show
    redirect_to controller: 'articles', liste_id: params[:id]
  end

  def root
    if !session[:user_id]
      redirect_to log_in_path

    else
      @listes = Liste.where(user_id: session[:user_id])
      if @listes.size > 0
        root_id = @listes[0].id
        redirect_to controller: 'articles', liste_id: root_id
      else
        redirect_to listes_path
      end
  end
  end

  def destroy
    @liste = Liste.find(params[:id])
    @liste.destroy
    redirect_to listes_path

  end


end
