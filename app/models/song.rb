class Song < ActiveRecord::Base
   	#include EchonestResource::Base
    #echonest_resource :song
   attr_reader :title,:year,:duration,:samp_rt,:tempo,:danceability,
   :energy,:loudness,:song_hot,:end_fade_in,:song_key,:start_fade_out
	belongs_to :artist
	belongs_to :album 			
	has_many :artist_terms

	scope :has_hot, where("song_hot > 0")
	scope :has_tempo, where("tempo >0")

def self.tempo_analysis(user_term)
  term = Term.find_by_term(user_term)
  freq_avg = term.freq_avg
  weight_avg = term.weight_avg 
  artist_ids = term.artist_terms
  .where("freq >#{freq_avg} AND weight >#{weight_avg}").map(&:artist_id)
  tempo = Song.select(:tempo).has_tempo.where(artist_id:artist_ids).map(&:_tempo)
  min_max = {min:tempo.min,max:tempo.max}
  groups =  self.divide_to_groups(min_max,20)
  self.count_songs_in_groups(groups,tempo)
end  

def self.by_term(user_term)
  Term.similarity(user_term)
end

def self.divide_to_groups(total,groups_num)
  groups =[]
  range = total[:max] - total[:min]
  range_differ = (range/groups_num)
  groups.push({min:total[:min],max:total[:min] + range_differ})
  index =1
  while index <= (groups_num - 1) 
    groups.push({min:groups[index-1][:max],max:groups[index -1][:max]+range_differ})    
  	index +=1
  end
  groups.each{|g| g[:max] = g[:max].round}
  groups.each{|g| g[:min] = g[:min].round}
  groups.each{|g| g.merge!({count:0})}
end	

def self.count_songs_in_groups(groups,tempo)
    tempo.each do |t|
      groups.each do |group|
        if (t > group[:min]) && t < group[:max]
          group[:count] +=1
        end  
      end  
    end     
  groups
end

def self.song_count_by_groups
  Song
end  
  	
def self.merge_to_main_groups(groups)

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

