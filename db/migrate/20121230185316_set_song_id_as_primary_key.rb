class SetSongIdAsPrimaryKey < ActiveRecord::Migration
  def up
  	execute "ALTER TABLE songs ADD PRIMARY KEY (track_id)"
  end

  def down
  end
end
