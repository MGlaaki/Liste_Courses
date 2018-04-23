class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate
    redirect_to '/' unless session[:user_id]
  end

  def root
    if !session[:user_id]
      redirect_to log_in_path

    else
      #@listes = Liste.where(user_id: session[:user_id])
      #if @listes.size > 0
        #root_id = @listes[0].id
        redirect_to controller: 'articles', liste_id: 0
      #else
      #  redirect_to listes_path
      #end
    end
  end
end
