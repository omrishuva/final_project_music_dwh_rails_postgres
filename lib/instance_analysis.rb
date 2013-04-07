
module InstanceAnalysis
	
	def self.included(klass)
    klass.extend(ClassMethods)
  end
	


	def analyze

	 	{
	     :self =>     self,
	     albums:      Album.get_year(albums), 
	     terms:       term_by_categories,
	     songs_count: songs.count,
	     similars:    similars_count,  
	     years_range: years_range
     }
	
	end		
	

	module ClassMethods
		

		def valid_attributes(attribute)
		  
		  self.where("#{attribute.to_s} IS NOT NULL AND #{attribute.to_s} > 0")
		end   

		def attributes
			columns = []
			self.columns.each do |column|
				columns << column.name
			end	
		columns
		end	
		
		def dimensions
			dims = [ ]
			relations =  self.reflect_on_all_associations(:has_many)
			 .reject{|hm| hm.class == ActiveRecord::Reflection::ThroughReflection}.map(&:name)
			relations.each do |hm|
				 dims << hm.to_s.split(/_/).join(" ")
			end 
		dims
		end	
		
		def to_table
			self.to_s.downcase.pluralize
		end

		def to_star_fk
			(("#{self.to_s.downcase}")+ "_id")
		end	
	
		def to_snow_fk
			(("#{to_table}")+ ".id")
		end	
	
	end 
end	