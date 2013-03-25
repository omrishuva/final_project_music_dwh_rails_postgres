class ChangArtistIdName < ActiveRecord::Migration
  def up
  	rename_column :artists, :artist_id, :id
  end

  def down
  	rename_column :artists,:id ,:artist_id
  end
end
