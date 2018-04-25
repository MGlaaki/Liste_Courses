class PartagesController < ApplicationController
  before_action :authenticate

  def index
  end

  def new
    @partage = Partage.new
    @listes = Liste.where(user_id: session[:user_id])
  end

  def create

  end


end
