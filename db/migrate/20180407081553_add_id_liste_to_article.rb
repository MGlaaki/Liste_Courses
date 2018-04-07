class AddIdListeToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :liste_id, :integer
  end
end
