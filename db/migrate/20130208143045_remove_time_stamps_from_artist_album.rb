class RemoveTimeStampsFromArtistAlbum < ActiveRecord::Migration
  def up
  	remove_column :artist_albums, :created_at
 	remove_column :artist_albums, :updated_at
  end

  def down
  	add_column :artist_albums, :created_at
 	add_column :artist_albums, :updated_at
  end
end
