class ArticlesController < ApplicationController
  #before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_liste, only: [:create, :destroy_all]
  before_action :authenticate

  # GET /articles
  # GET /articles.json
  def index
    #@listes = Liste.references(:article).where(user_id: session[:user_id])
    @listes = Liste.owner_and_shared_with(session[:user_id]).includes(:article)

    @listes.each do |l|
      if l.id.to_s == params[:liste_id]
        @liste = l
        @articles = @liste.article
      end
    end

    @article = Article.new(:liste => @liste)
  end

  #  GET /articles/new
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
    @article = Article.find(params[:id])
    @article.delete
    respond_to do |format|
      format.html { redirect_to liste_articles_url, notice: 'Elément supprimé' }
    end
  end

  def destroy_all
    @articles = @liste.article.all? { |e|  }
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
