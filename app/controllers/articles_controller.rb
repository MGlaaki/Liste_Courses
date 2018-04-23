class ArticlesController < ApplicationController
  #before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_liste, only: [:create, :destroy, :destroy_all]
  before_action :authenticate

  # GET /articles
  # GET /articles.json
  def index
    @listes = Liste.where(user_id: session[:user_id])

    @listes.each do |l|
      @liste = l if l.id.to_s == params[:liste_id]
    end

    if (@liste.user_id != session[:user_id])
      redirect_to "/"
    end

    @articles = @liste.article.all
    @article = Article.new(:liste => @liste)
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = @liste.article.build
    @article.article = params[:article][:article]


    respond_to do |format|
      if @article.save
        format.html { redirect_to liste_articles_url, notice: 'Elément ajouté.' }
      else
        format.html { redirect_to liste_articles_url, alert: 'Impossible d\'ajouter un élément vide'}
      end
    end
  end


  # DELETE /articles/1
  def destroy
    @article = @liste.article.find(params[:id])
    @article.delete
    respond_to do |format|
      format.html { redirect_to liste_articles_url, notice: 'Elément supprimé' }
    end
  end

  def destroy_all
    @articles = @liste.article.all
    @articles.delete_all
    respond_to do |format|
      format.html { redirect_to liste_articles_url, notice: 'Reset liste effectué'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_liste
      @liste = Liste.find(params[:liste_id])
    end

  end
