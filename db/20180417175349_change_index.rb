class ChangeIndex < ActiveRecord::Migration[5.1]
  def change
    remove_index :listes, :nom_liste
  end
end
