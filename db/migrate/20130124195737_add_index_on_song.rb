class AddIndexOnSong < ActiveRecord::Migration
  def up
  	add_index :songs , :tempo
  	add_index :songs , :song_hot
  	add_index :songs , :danceability
  	add_index :songs , :loudness
  	add_index :songs ,  :energy
  	add_index :songs ,  :song_key
  end

  def down
  	remove_index :songs , :tempo
  	remove_index :songs , :song_hot
  	remove_index :songs , :danceability
  	remove_index :songs , :loudness
  	remove_index :songs ,  :energy
  	remove_index :songs ,  :song_key
  end
end
