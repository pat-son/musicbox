class AddFeaturedToCreations < ActiveRecord::Migration[5.0]
  def change
    add_column :creations, :featured, :boolean
  end
end
