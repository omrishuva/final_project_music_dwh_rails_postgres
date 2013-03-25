class Term < ActiveRecord::Base
   include InstanceAnalysis
   attr_accessible :term  ,:category  
   
   has_many :artist_terms 
   has_many :artists ,:through=>:artist_terms 
   
   scope :type ,  lambda{|type| where(category:type)}
   scope :main ,  where("count>(SELECT AVG(count) FROM terms)")
   scope :sub  ,  where("count<(SELECT AVG(count) FROM terms)")
   
#similarity methods

   def songs(attr_type)
     artist_ids = artists.map(&:id)
     songs = Song.where(artist_id:artist_ids).select(Song.attr_return(attr_type))
   end
   
   def artist_ids
     artists.map(&:id).uniq
   end   

   def self.split_by_categories(related_terms)
    categories = []
    related_terms_splited = []
    related_terms.each { |t| categories.push(t[:category]) }
    if categories
      categories.uniq!.each do |category|
        related_terms_splited.push(related_terms.select{ |related| related[:category] == category })   
      end  
    end
    related_terms_splited 
   end  
   
   def similarity
     related_terms = []
     terms_ids = ArtistTerm.where(id:artist_ids).map(&:term_id)
     uniq_terms_ids = terms_ids.uniq
     uniq_terms = Term.where(id:uniq_terms_ids) 
     total_count = total_strengh = 0 
     uniq_terms.each do |uniq_term|
       name = uniq_term.term  
       term_count =  terms_ids.count(uniq_term.id)
       total_count += term_count 
       strengh = (term_count.to_f/uniq_term[:count])  
       total_strengh += strengh
       related_terms.push( { id:uniq_term.id,term:name,count:term_count,strengh:strengh,category:uniq_term.category } )
     end 
     binding.pry
     count_avg  = (total_count/related_terms.size)
     strengh_avg = (total_strengh/related_terms.size)
     related_terms.reject! { |t| t[:term] == self.term }
     related_terms.reject! { |t| t[:count] < count_avg || t[:strengh] < strengh_avg }
     final_list = related_terms.sort_by { |related| related[:count] && related[:strengh] }.reverse!
     Term.split_by_categories(final_list).sort_by { |category| category.size }.reverse 
   end  
    
   def select_distinct_artist
    terms = similarity
       
   end 

  #tempo analysis methods
  def tempo_analysis
    artist_ids = artist_terms.where("freq >#{freq_avg} AND weight >#{weight_avg}").map(&:id)
    tempo = Song.select(:tempo).has_tempo.where(artist_id:artist_ids).map(&:_tempo)
    min_max = {min:tempo.min,max:tempo.max}
    groups =  self.divide_to_groups(min_max,20)
    self.count_songs_in_groups(groups,tempo)
  end  


  def divide_to_groups(total,groups_num)
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

  def count_songs_in_groups(groups,tempo)
      tempo.each do |t|
        groups.each do |group|
          if (t > group[:min]) && t < group[:max]
            group[:count] +=1
          end  
        end  
      end     
    groups
  end
 
 def update_artist_terms
  artist_terms.each do |at|
    at.update_attributes(category:category)
  end
 end   

end


