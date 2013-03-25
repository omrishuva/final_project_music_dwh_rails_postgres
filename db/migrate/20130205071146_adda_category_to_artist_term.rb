class AddaCategoryToArtistTerm < ActiveRecord::Migration
  def up
  	add_column :artist_terms, :category, :string
  end

  def down
  	remove_column :artist_terms, :category
  end
end
