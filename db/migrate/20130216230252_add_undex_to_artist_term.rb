class AddUndexToArtistTerm < ActiveRecord::Migration
  def up
  	add_index :artist_terms ,:name
  end

  def down
  	remove_index :artist_terms ,:name
  end
end
