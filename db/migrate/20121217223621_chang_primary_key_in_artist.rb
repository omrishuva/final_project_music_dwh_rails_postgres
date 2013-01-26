class ChangPrimaryKeyInArtist < ActiveRecord::Migration
  def up
  	remove_column :artists, :id
  	execute "ALTER TABLE artists ADD PRIMARY KEY (artist_id)"
  end
end
