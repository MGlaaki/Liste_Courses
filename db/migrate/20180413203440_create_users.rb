class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_hash
      t.string :salt

      t.timestamps
    end
  end
end
