class ChangeColumnNull < ActiveRecord::Migration[5.1]
  def change
    change_column_null :listes, :utilisateur, false
    change_column_null :listes, :nom_liste, false
  end
end
