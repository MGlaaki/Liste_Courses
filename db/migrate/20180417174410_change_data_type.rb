class ChangeDataType < ActiveRecord::Migration[5.1]
  def change
    remove_column :listes, :utilisateur
    add_column :listes, :user_id, :integer
  end
end
