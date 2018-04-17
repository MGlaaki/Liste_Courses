class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @liste = Liste.find(params[:liste_id])
    if (@liste.user_id != session[:user_id])
      redirect_to "/"
    end
    @listes = Liste.where(user_id: session[:user_id])
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
    @liste = Liste.find(params[:liste_id])
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
    liste = Liste.find(params[:liste_id])
    @article = liste.article.find(params[:id])
    @article.delete
    respond_to do |format|
      format.html { redirect_to liste_articles_url, notice: 'Elément supprimé' }
    end
  end

  def destroy_all
    @liste = Liste.find(params[:liste_id])
    @articles = @liste.article.all
    @articles.delete_all
    respond_to do |format|
      format.html { redirect_to liste_articles_url, notice: 'Reset liste effectué'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:article, :ajoutepar)
    end
end
