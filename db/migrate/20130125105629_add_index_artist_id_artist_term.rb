class AddIndexArtistIdArtistTerm < ActiveRecord::Migration
  def up
  	add_index :artist_terms , :artist_id
  end

  def down
  	remove_index :artist_terms , :artist_id
  end
end
