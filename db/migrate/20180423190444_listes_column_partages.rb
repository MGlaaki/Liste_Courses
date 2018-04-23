class ListesColumnPartages < ActiveRecord::Migration[5.1]
  def change
    add_column :partages, :liste_id, :integer
  end
end
