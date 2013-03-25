class AddIndexOnArtistIdSimilarity < ActiveRecord::Migration
  def up
  	add_index :similarities ,:artist_id
  end

  def down
  	remove_index :similarities ,:artist_id
  end
end
