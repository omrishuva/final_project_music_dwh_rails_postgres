class Album < ActiveRecord::Base
   attr_accessible :name,:album_id
   has_many :songs , :foreign_key => :album_id
   has_many :artist_albums
   has_many :artists ,:through=>:artist_albums  

   def self.get_year(albums)
   	 album_details =[]
   	 albums.each do |a|
   	   album_details.push({	
   	   name: a[:name],
   	   min_year: a.songs.has_year.minimum(:year),
   	   max_year: a.songs.has_year.maximum(:year)
	  })
     end
   album_details
   end	

end
