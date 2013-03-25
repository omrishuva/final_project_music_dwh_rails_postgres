class Song < ActiveRecord::Base
   
   include InstanceAnalysis
   
   attr_reader :title,:year,:duration,:samp_rt,:tempo,:danceability,
   :energy,:loudness,:song_hot,:end_fade_in,:song_key,:start_fade_out
	belongs_to :artist, :counter_cache => true
	belongs_to :album
	has_many :artist_terms
	scope :has_year, where("year != 0 ")
	scope :has_hot, where("song_hot > 0")
	scope :has_tempo, where("tempo >0")
	
	def analysis (search_term)
		artist = Artist.find_by_artist_name(search_term) 
    
    {
      artist:      artist,
      albums:      Album.get_year(artist.albums), 
      terms:       artist.term_by_categories,
      songs_count: artist.songs.count,
      similars:    artist.similars_count,  
      years_range: artist.years_range
    }
	end	

	def self.by_term(user_term,type)
		artist_ids=Term.artist_ids_by_term(user_term)
		Song.where(artist_id:artist_ids).select(attr_return type)
	end	

def self.attr_return(attr_type)
	case attr_type
	when "info"
		"title,year,song_hot,danceability,energy,loudness,duration,tempo,song_key,artist_id"		
	end	
end

def self.songs_by_artist(ids_arr,attr_type)
	Song.where(artist_id:ids_arr).select(attr_return attr_type)
end	

# def self.artist_by_term
# 	Artist.joins(:artist_terms).where("artist_terms.name IN ?"user_terms)
# end	
# def self.avg_dance_by_term(term)
# 	Song.by_term(term).select("avg(danceability)")
# end	





end

