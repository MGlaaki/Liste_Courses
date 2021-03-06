class ListesController < ApplicationController
  before_action :authenticate

  def index
    @listes = Liste.owner_and_shared_with(session[:user_id])

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
      render new_liste_path
    end
  end

  def show
    redirect_to controller: 'articles', liste_id: params[:id]
  end


  def destroy
    @liste = Liste.find(params[:id])
    @liste.destroy
    redirect_to listes_path
  end



end
