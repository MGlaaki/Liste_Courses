class CreateListes < ActiveRecord::Migration[5.1]
  def change
    create_table :listes do |t|
      t.string :utilisateur
      t.string :nom_liste

      t.timestamps
    end
    add_index :listes, [:utilisateur, :nom_liste], unique: true
  end
end
