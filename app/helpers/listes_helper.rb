module ListesHelper

  def listes_user_actif(all_listes)
    all_listes.select{|l| l.user_id == session[:user_id]}
  end

  def owns_listes?(all_listes)
    listes_user_actif(all_listes).size > 0
  end

  def listes_partagees(all_listes)
    all_listes.select{|l| l.user_id != session[:user_id]}
  end

  def receives_listes?(all_listes)
    listes_partagees(all_listes).size > 0
  end

end
