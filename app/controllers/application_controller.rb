class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate, only: :root

  def authenticate
    redirect_to log_in_path unless session[:user_id]
  end

  def root
    @liste = Liste.owner_and_shared_with(session[:user_id]).first
    redirect_to controller: 'articles', liste_id: @liste.id
  rescue NoMethodError
    redirect_to listes_path
  end

end
