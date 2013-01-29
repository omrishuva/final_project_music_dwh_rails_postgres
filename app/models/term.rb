class Term < ActiveRecord::Base
   attr_accessible :term  ,:category  
   
   has_many :artist_terms
   has_many :artists ,:through=>:artist_terms 
   
   scope :type ,  lambda{|type| where(category:type)}
   scope :main ,  where("count>(SELECT AVG(count) FROM terms)")
   scope :sub  ,  where("count<(SELECT AVG(count) FROM terms)")
   


   def songs(attr_type)
     artist_ids = artists.map(&:artist_id)
     songs = Song.where(artist_id:artist_ids).select(Song.attr_return(attr_type))
   end
   
   def self.artist_ids_by_term(user_term)
     self.where(term:user_term).first.artists.map(&:_artist_id).uniq
   end   
   
   def self.similarity(user_term)
     related_terms = []
     artist_ids = self.artist_ids_by_term(user_term.to_s)
     terms_ids = ArtistTerm.where(artist_id:artist_ids).map(&:term_id)
     uniq_terms_ids = terms_ids.uniq
     uniq_terms = Term.where(id:uniq_terms_ids) 
     total_count = 0
     uniq_terms.each do |term|
       name = term.term
       terms_count =  terms_ids.count(term.id)
       total_count += terms_count 
       strengh = (terms_count.to_f/term[:count])  
       related_terms.push({term:name,count:terms_count,strengh:strengh})
     end 
     count_avg  = (total_count/related_terms.size)
     related_terms.reject! {|t| t[:term] == user_term }
     related_terms.reject! {|t| t[:count] < count_avg }
     related_terms.sort_by {|k| k[:strengh]}.reverse![1..related_terms.size]
   end  
    
end
