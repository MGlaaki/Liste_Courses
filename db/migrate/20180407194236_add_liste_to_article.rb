class AddListeToArticle < ActiveRecord::Migration[5.1]
  def change
    remove_column :articles, :liste_id
    add_reference :articles, :liste, foreign_key: true
  end
end
