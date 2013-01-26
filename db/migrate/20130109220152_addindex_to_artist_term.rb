class AddindexToArtistTerm < ActiveRecord::Migration
  def up
  add_index :artist_terms ,:term_id
  end

  def down
  remove_index :artist_terms ,:term_id 
  end
end
