class ArtistTerm < ActiveRecord::Base
   attr_accessible :name,:category
   belongs_to :artist,  :class_name => "Artist", :foreign_key => :artist_id
   belongs_to :term
   
   def self.avg_of_attr_by_term(user_term)
   		self.average(:freq)
   end	
   
   def self.artist_id_by_terms(user_terms,limit_num=nil)
   		ArtistTerm.where(name:user_terms).limit(limit_num).map(&:artist_id)
   end

end