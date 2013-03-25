class AddSongCountToArtist < ActiveRecord::Migration
  
  def up
  	add_column :artists , :songs_count, :integer, :default => 0
  end

  def down
  	remove_column :artists , :songs_count
  end


end
