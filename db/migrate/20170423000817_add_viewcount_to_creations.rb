class AddViewcountToCreations < ActiveRecord::Migration[5.0]
  def change
    add_column :creations, :viewcount, :integer, default: 0
  end
end
