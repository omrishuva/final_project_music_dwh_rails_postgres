class DeleteIdFromSongs < ActiveRecord::Migration
  def up
  	remove_column :songs, :id
  end

  def down
  	add_column :songs, :id, :integer
  end
end
