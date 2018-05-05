module ApplicationHelper

    def current_controller?(names)
      controller_name.include?(names)
    end

    def partages_links
      create = link_to "Partager une liste", new_partage_path unless current_controller?('partages') && action_name == "new"
      edit = link_to "Editer les partages", partages_path unless current_controller?('partages') && action_name == "index"
      [create,edit].reject{|a| a.nil?}.join(' / ').html_safe
    end

    def listes_links
      create =  link_to "Nouvelle liste", new_liste_path
      edit = link_to "Editer les listes", listes_path
      current_controller?('listes') && action_name == "index" ? create : edit
  end

end
