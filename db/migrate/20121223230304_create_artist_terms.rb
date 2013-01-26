class CreateArtistTerms < ActiveRecord::Migration
  def change
    create_table :artist_terms do |t|
      t.string	 :artist_id 
      t.string	 :song_id
      t.string	 :name
      t.float	 :freq
      t.float 	 :weight	
    end
  end
end
