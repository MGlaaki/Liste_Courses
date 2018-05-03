class PartagesController < ApplicationController
  before_action :authenticate

  def index
    @test = params[:format]
  end

  def new
    @partage = Partage.new
    @listes = Liste.where(user_id: session[:user_id])
    @source_liste = params[:liste_id]


  end

  def create
    session[:return_to] ||= request.referer

    @users =  User.where("name = ? AND id != ?", "#{params[:partage][:destinataire_name]}","#{session[:user_id].to_i}").to_a

    if @users.size != 1
      @users = User.where("name LIKE ? AND id != ?", "%#{params[:partage][:destinataire_name]}%","#{session[:user_id].to_i}").to_a
    end

    if @users.size == 1
      @partage = Partage.new
      @partage.proprietaire_id = session[:user_id]
      @partage.destinataire_id = @users[0].id
      @partage.liste_id = params[:partage][:liste_id]
       if @partage.save
        redirect_to "/"
      else
        redirect_to session.delete(:return_to), alert: @partage.errors.messages
      end
    else
          error = @users.size == 0 ? "Aucun utilisateur trouvé" : "Plusieurs utilisateurs trouvés \n"
      @users.each{|u| error << u.name << "\n"}
      redirect_to session.delete(:return_to), alert: error
    end
  end


end
