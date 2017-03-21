class CreateCreations < ActiveRecord::Migration[5.0]
  def change
    create_table :creations do |t|
      t.text :data
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
