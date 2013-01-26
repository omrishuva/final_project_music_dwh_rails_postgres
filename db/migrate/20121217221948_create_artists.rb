class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
    	t.string :artist_id
    	t.string :artist_7digital_id
    	t.string :artist_mbid
    	t.string :artist_pm_id
    	t.string :artist_name
    	t.float  :artist_hotness
    	t.float  :artist_fam 
    end
  end
end
