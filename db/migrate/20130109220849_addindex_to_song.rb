class AddindexToSong < ActiveRecord::Migration
  def up
  	  add_index :songs ,:artist_id
  end

  def down
  	remove_index :songs ,:artist_id
  end
end
