class RenameAlbumIdToId < ActiveRecord::Migration
  
  def up
 	rename_column :albums, :album_id, :id
  end
 
 end
