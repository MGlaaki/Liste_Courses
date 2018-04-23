class CreatePartages < ActiveRecord::Migration[5.1]
  def change
    create_table :partages do |t|
      t.references :proprietaire
      t.references :destinataire

      t.timestamps
    end
  end
end
