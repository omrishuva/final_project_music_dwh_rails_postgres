class AddIndexOnAlbumId < ActiveRecord::Migration
  def up
  	add_index :songs ,:album_id
  end

  def down
  	remove_index :songs ,:album_id
  end
end
