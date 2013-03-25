class CreateArtistAlbums < ActiveRecord::Migration
  def change
    create_table :artist_albums do |t|
      t.string :artist_id
      t.string :album_id	
      t.timestamps
    end
  end
end
